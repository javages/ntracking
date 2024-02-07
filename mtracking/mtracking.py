import json
from datetime import datetime, timedelta
import glob
import matplotlib.pyplot as plt
import random

# Number of random colors you want to generate
num_colors = 10

# Extract 20 unique colors from the 'tab20c' colormap
all_colors = plt.cm.tab20c(range(20))

# Randomly select 'num_colors' from the list
selected_colors = random.sample(list(all_colors), num_colors)

# Convert selected colors to hex format for HTML/CSS usage
hex_colors = ['#' + ''.join([f"{int(c*255):02x}" for c in color[:3]]) for color in selected_colors]


# Define the pattern to match the log files (e.g., 'machine_resources*.log')
log_file_pattern = 'M*'

# Use glob to find all matching log files and sort them
log_files = sorted(glob.glob(log_file_pattern))

def extract_vnstat_data(log_content):
    """
    Extracts and processes the vnStat data from the log content.
    """
    json_start = log_content.find('{"vnstatversion":')
    if json_start == -1:
        return "No vnStat data found."
    
    json_str = log_content[json_start:]

    try:
        vnstat_data = json.loads(json_str)
    except json.JSONDecodeError:
        return "Error decoding vnStat JSON data."
    
    return vnstat_data

def calculate_total(data):
    total_rx = sum(entry['rx'] for entry in data)
    total_tx = sum(entry['tx'] for entry in data)
    return total_rx, total_tx

def get_specific_vnstat_data(vnstat_data):
    """
    Extracts "Last week", "Yesterday", and "Today" data from vnStat data.
    """
    today = datetime.now().date()
    yesterday = today - timedelta(days=1)
    last_week_start = today - timedelta(days=7)
    last_week_end = yesterday - timedelta(days=1)  # Exclude yesterday

    specific_data = {
        "Last week": [],
        "Yesterday": [],
        "Today": []
    }

    for interface in vnstat_data.get("interfaces", []):
        for entry in interface.get("traffic", {}).get("day", []):
            entry_date = datetime(entry["date"]["year"], entry["date"]["month"], entry["date"]["day"]).date()
            if last_week_start <= entry_date <= last_week_end:
                specific_data["Last week"].append(entry)
            elif entry_date == yesterday:
                specific_data["Yesterday"].append(entry)
            elif entry_date == today:
                specific_data["Today"].append(entry)

    return specific_data

def bytes_to_gb(bytes_value):
    """
    Converts bytes to gigabytes.
    """
    return bytes_value / (2**30)

def process_log_files(log_files):
    log_data = []

    for log_file in log_files:
        with open(log_file, 'r') as file:
            content = file.read()

            # Extract vnStat data
            vnstat_data = extract_vnstat_data(content)

            # Extract specific vnStat data
            vnstat_data_specific = get_specific_vnstat_data(vnstat_data)

            # Extract CPU, RAM, and Disk usage
            cpu_usage = content.split('\n')[0].split(': ')[1]
            ram_usage = content.split('\n')[1].split(': ')[1]
            disk_usage = content.split('\n')[2].split(': ')[1]

            # Calculate total RX and TX for each period and convert to GB
            total_last_week_rx, total_last_week_tx = calculate_total(vnstat_data_specific["Last week"])
            total_yesterday_rx, total_yesterday_tx = calculate_total(vnstat_data_specific["Yesterday"])
            total_today_rx, total_today_tx = calculate_total(vnstat_data_specific["Today"])

            # Include data in the file_data dictionary
            file_data = {
                "file_name": log_file,
                "cpu_usage": cpu_usage,
                "ram_usage": ram_usage,
                "disk_usage": disk_usage,
                "total_last_week_rx_gb": bytes_to_gb(total_last_week_rx),
                "total_last_week_tx_gb": bytes_to_gb(total_last_week_tx),
                "total_yesterday_rx_gb": bytes_to_gb(total_yesterday_rx),
                "total_yesterday_tx_gb": bytes_to_gb(total_yesterday_tx),
                "total_today_rx_gb": bytes_to_gb(total_today_rx),
                "total_today_tx_gb": bytes_to_gb(total_today_tx)
            }
            log_data.append(file_data)

    return log_data

def generate_html_report(log_data):
    html_content = """
    <!DOCTYPE html>
    <html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style>
            body {
                background-color: black; /* Light grey background */
                color: #333; /* Dark text for readability */
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                margin: 0;
                padding: 0;
                text-align: left;
            }

            .container {
                position: relative;
                max-width: 800px;
                margin: 20px auto;
                background-color: #242323;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                padding: 20px;
                border-radius: 8px;
            }

            .home-icon {
                position: absolute;
                top: 2px; /* Adjust as needed for spacing from the top */
                left: 20px; /* Adjust as needed for spacing from the left */
                z-index: 10; /* Ensures the icon is above other elements */
            }

            .home-icon img {
                width: 24px; /* Set the width as desired */
                height: auto; /* Height is set to auto to maintain aspect ratio */
                display: block;
                opacity: 75%;
            }
                
            h2 {
                font-size: 16px;
                text-align: center;
                color: #c7f6fc; /* A blue shade from tab20c */
                margin-bottom: 20px;
            }

            p {
                font-size: 10px;
                line-height: 1.6;
            }

            hr {
                border: 0; /* Remove the default border */
                height: 1px; /* Set the height of the line */
                background: #333; /* Light grey color for the faint line */
                margin: 30px 0; /* Add some space before and after the line */
            }

            .data-section {
                padding: 10px;
                margin: 5px 0;
                border-radius: 4px;
            }

            .data-section:nth-child(odd) {
                background-color: #636363;
                color: white;
            }

            .data-section:nth-child(even) {
                background-color: #969696;
                color: white;
            }

            .data-title {
                font-weight: bold;
                color: white; /* A green shade from tab20c */
            }
            
            .data-value-rx { color: white; }
            .data-value-tx { color: white; }
            .data-value-total { color: white; }
           
            .data-row {
                display: flex;
                justify-content: start; /* Align to the start to bring items closer */
                margin-bottom: 5px; /* Adjust as needed for space between rows */
            }

            .data-title {
                flex: 0 0 auto; /* Do not grow or shrink, but based on content width */
                margin-right: 10px; /* Adjust the space between the title and the value */
                white-space: nowrap; /* Prevents wrapping of the title text */
            }

            .data-value {
                flex: 1; /* Allows this element to grow and fill the remaining space */
                text-align: left; /* Aligns the text to the left */
            }

        </style>
    </head>
    <body>
    <div class="container">
        <a href="index.html" class="home-icon">
            <img src="home.png" alt="Home">
        </a>
    """

    for data in log_data:
        # Remove the .log extension from the file name
        file_name_without_extension = data['file_name'].replace('.log', '')

        html_content += "<div class='data-section'>"
        html_content += f"<h2>{file_name_without_extension}</h2>"
        html_content += f"<div class='data-row'><div class='data-title'>CPU Usage:</div><div class='data-value'>{data['cpu_usage']}</div></div>"
        html_content += f"<div class='data-row'><div class='data-title'>RAM Usage:</div><div class='data-value'>{data['ram_usage']}</div></div>"
        html_content += f"<div class='data-row'><div class='data-title'>Disk Usage:</div><div class='data-value'>{data['disk_usage']}</div></div>"
        html_content += f"<hr>"
        html_content += f"<div class='data-row'><div class='data-title'>Week:</div><div class='data-value'><span class='data-value-rx'>RX {data['total_last_week_rx_gb']:.2f}</span>, <span class='data-value-tx'>TX {data['total_last_week_tx_gb']:.2f}</span>, <span class='data-value-total'>Tot {(data['total_last_week_rx_gb'] + data['total_last_week_tx_gb']):.2f} GB</span></div></div>"
        html_content += f"<div class='data-row'><div class='data-title'>24Hr:</div><div class='data-value'><span class='data-value-rx'>RX {data['total_yesterday_rx_gb']:.2f}</span>, <span class='data-value-tx'>TX {data['total_yesterday_tx_gb']:.2f}</span>, <span class='data-value-total'>Tot {(data['total_yesterday_rx_gb'] + data['total_yesterday_tx_gb']):.2f} GB</span></div></div>"
        html_content += f"<div class='data-row'><div class='data-title'>Today:</div><div class='data-value'><span class='data-value-rx'>RX {data['total_today_rx_gb']:.2f}</span>, <span class='data-value-tx'>TX {data['total_today_tx_gb']:.2f}</span>, <span class='data-value-total'>Tot {(data['total_today_rx_gb'] + data['total_today_tx_gb']):.2f} GB</span></div></div>"
        html_content += "</div>"

    html_content += """
    </div>
    </body>
    </html>
    """

    return html_content

# Process the log files
processed_data = process_log_files(log_files)

# Generate HTML report
output_html = generate_html_report(processed_data)

# Output the generated HTML to a file
with open('mtracking.html', 'w') as output_file:
    output_file.write(output_html)
