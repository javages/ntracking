import re
from datetime import datetime
import glob

def parse_log(file_path):
    with open(file_path, 'r') as f:
        content = f.read()
    
    entries = content.split('------------------------------------------')
    
    # Required fields
    number_pattern = r"Number: (\d+)"
    node_pattern = r"Node: ([\w\d]+)"
    pid_pattern = r"PID: (\d+)"
    reward_pattern = r"Rewards balance: ([\d.]+)"
    timestamp_pattern = r"Global \(UTC\) Timestamp: (.+?)\n"
    status_pattern = r"Status: (\w+)"
    peer_id_pattern = r"Peer ID: ([\w\d]+)"


    parsed_entries = []
    dead_nodes = []  # List to store killed nodes
    
    log_number_match = re.search(r"resources(\d+)\.log$", file_path)
    log_number = int(log_number_match.group(1)) if log_number_match else 0
    
    for entry in entries:
        number_match = re.search(number_pattern, entry)
        node_match = re.search(node_pattern, entry)
        pid_match = re.search(pid_pattern, entry)
        reward_match = re.search(reward_pattern, entry)
        timestamp_match = re.search(timestamp_pattern, entry)
        status_match = re.search(status_pattern, entry)
        peer_id_match = re.search(peer_id_pattern, entry)
        peer_id = peer_id_match.group(1) if peer_id_match else None

        
        if all([number_match, node_match, pid_match, reward_match, timestamp_match, status_match]):
            timestamp = datetime.strptime(timestamp_match.group(1), '%a %b %d %H:%M:%S UTC %Y')
            parsed_entry = {
                'Number': int(number_match.group(1)),
                'Node': node_match.group(1),
                'PID': int(pid_match.group(1)),
                'Reward': float(reward_match.group(1)),
                'Timestamp': timestamp,
                'Status': status_match.group(1),
                'LogNumber': log_number
            }
            if peer_id:
                parsed_entry['PeerID'] = peer_id

            parsed_entries.append(parsed_entry)
            
            identifier = (parsed_entry['Number'], parsed_entry['Node'], parsed_entry['PID'])
            
            if parsed_entry['Status'] == 'killed' and identifier not in [(x['Number'], x['Node'], x['PID']) for x in dead_nodes]:
                dead_nodes.append(parsed_entry)
    
    return parsed_entries, dead_nodes

def main():
    all_entries = []
    all_dead_nodes = []
    
    for file_path in glob.glob("resources*.log"):
        entries, dead_nodes = parse_log(file_path)
        all_entries.extend(entries)
        all_dead_nodes.extend(dead_nodes)
        all_dead_nodes = sorted(all_dead_nodes, key=lambda x: (x['LogNumber'], x['Number']), reverse=False)

    unique_entries = {}
    for entry in all_entries:
        key = (entry['Number'], entry['Node'], entry['PID'])
        if key not in unique_entries or unique_entries[key]['Timestamp'] < entry['Timestamp']:
            unique_entries[key] = entry

    sorted_entries = sorted(unique_entries.values(), key=lambda x: (x['LogNumber'], x['Number']), reverse=False)
    total_reward = sum([entry['Reward'] for entry in unique_entries.values()])
    
    running_nodes = set(entry['Node'] for entry in unique_entries.values() if entry['Status'] == 'running')
    killed_nodes = set(entry['Node'] for entry in unique_entries.values() if entry['Status'] == 'killed')
    
    with open("node_info.txt", "w") as outfile:
        outfile.write("= ntracking =\n")
        outfile.write(f"Rewards: {total_reward:.8f}\n")
        outfile.write(f"Running: {len(running_nodes)}\n")
        outfile.write(f"Killed: {len(killed_nodes)}\n\n\n")

        if all_dead_nodes:
            outfile.write("=== Killed Nodes Details ===\n")
            for node in all_dead_nodes:
                outfile.write(f"Number: {node['LogNumber']}:{node['Number']}\n")
                outfile.write(f"Node: {node['Node']}\n")
                if 'PeerID' in node:
                    outfile.write(f"Peer ID: {node['PeerID']}\n")
                outfile.write(f"PID: {node['PID']}\n")
                outfile.write(f"Status: {node['Status']}\n")
                outfile.write(f"Timestamp: {node['Timestamp'].strftime('%a %b %d %H:%M:%S UTC %Y')}\n")
                outfile.write(f"Rewards balance: {node['Reward']:.8f}\n")
                outfile.write("---------\n\n")
    
        outfile.write("=== All Live Nodes ===\n\n")
        
        for entry in sorted_entries:
            outfile.write(f"Number: {entry['LogNumber']}:{entry['Number']}\n")
            outfile.write(f"Node: {entry['Node']}\n")
            if 'PeerID' in entry:
                outfile.write(f"Peer ID: {entry['PeerID']}\n")
            outfile.write(f"PID: {entry['PID']}\n")
            outfile.write(f"Rewards balance: {entry['Reward']:.8f}\n")
            outfile.write("---------\n")

if __name__ == "__main__":
    main()
