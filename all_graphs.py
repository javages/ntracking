import os
import warnings
import glob
import pandas as pd
import numpy as np
import plotly.express as px
import matplotlib.pyplot as plt
import warnings
import re
warnings.simplefilter(action='ignore', category=FutureWarning)

user_home = os.path.expanduser("~")
datadir = os.path.join(user_home, ".local", "share", "ntracking")

def convert_value(value, format_type, default=0):
    if format_type == 'float':
        try:
            return float(value)
        except ValueError:
            return default
    elif format_type == 'int':
        try:
            return int(value)
        except ValueError:
            return default
    elif format_type == 'float_mb':
        try:
            return float(value.replace("MB", "").strip())
        except ValueError:
            return default
    elif format_type == 'float_percent':
        try:
            return float(value.replace("%", "").strip())
        except ValueError:
            return default
    return value

# Sort log files with leading 0
def sort_log_files(file_list):
    def extract_number(file_name):
        # Extract the number from the file name using regular expression
        match = re.search(r'(\d+)', file_name)
        return int(match.group()) if match else 0

    return sorted(file_list, key=extract_number)


def combined_extract_data(filenames):
    filenames = sort_log_files(filenames)
    all_data = []

    for file_number, filename in enumerate(filenames):
        with open(filename, "r") as file:
            lines = file.readlines()

        formats = {
            "Memory used": "float_mb",
            "Records": "int",
            "Disk usage": "float_mb",
            "Rewards balance": "float",
            "Number": "int",
            "PID": "int"
        }

        data = []
        idx = 0
        while idx < len(lines):
            if "Global (UTC) Timestamp:" in lines[idx]:
                timestamp = lines[idx].split(": ", 1)[1].strip()
                entry_data = {"Global (UTC) Timestamp": timestamp}
               
                idx += 1
                while idx < len(lines) and "------------------------------------------" not in lines[idx]:
                    if ": " in lines[idx]:
                        key, raw_value = lines[idx].split(": ", 1)
                        raw_value = raw_value.strip()

                        if raw_value == "N/A":
                            value = np.nan
                        elif key in formats:
                            value = convert_value(raw_value, formats[key])
                        else:
                            value = raw_value

                        if key == "Number":
                            entry_data[key] = f"{file_number}:{value}"
                        else:
                            entry_data[key] = value

                        if key == "PID":
                            if raw_value: 
                                entry_data[key] = int(raw_value)
                            else:
                                entry_data[key] = None 


                    idx += 1
                data.append(entry_data)
            else:
                idx += 1

        all_data.extend(data)

    # DataFrame for rewards_visualize and memory_visualize
    line_df = pd.DataFrame(all_data)
    line_df["Timestamp"] = pd.to_datetime(line_df["Global (UTC) Timestamp"], format='%a %b %d %H:%M:%S %Z %Y', errors='coerce')
    if line_df["Timestamp"].dt.tz is None:
        line_df["Timestamp"] = line_df["Timestamp"].dt.tz_localize('UTC')

    # DataFrame for logarithmic_bubble_visualize
    bubble_df = line_df.copy().dropna(subset=["Timestamp"])
    bubble_df = bubble_df.groupby("Node").last().reset_index()

    return line_df, bubble_df

def generate_Number_to_color(Number):
    colormap = plt.cm.tab20c
    Number_colors = [colormap(i % 20) for i in range(len(Number))]
    Number_colors_str = ["rgb({:.0f}, {:.0f}, {:.0f})".format(r*255, g*255, b*255) for r, g, b, _ in Number_colors]
    return {Number: Number_colors_str[i] for i, Number in enumerate(Number)}

# Visualization
custom_hovertemplate = "%{customdata[3]}<br>"

def layout(fig, yaxis_title_text, hover_template):
    
    # Hide the x-axis labels
    fig.update_layout(
        xaxis_title_text="",
        yaxis_title_text=yaxis_title_text
    )
    
    for trace in fig.data:
        trace.hovertemplate = hover_template

    # General layout
    fig.update_layout(
        hovermode='closest',
        paper_bgcolor='black',  # Set to black for the border effect
        plot_bgcolor='#070D0D',  # Keep the plot background color as is
        margin=dict(t=1, b=1, l=2, r=1, pad=1),  # Adjust the margin for a thin border
        xaxis=dict(
            rangeselector=dict(
                buttons=[
                    dict(count=6, label="6 hours", step="hour", stepmode="backward"),
                    dict(count=12, label="12 hours", step="hour", stepmode="backward"),
                    dict(count=1, label="24 hours", step="day", stepmode="backward"),
                    dict(count=2, label="2 days", step="day", stepmode="backward"),
                    dict(step="all", label="All Data")
                ],
                font=dict(color="#ffffff"),
                bgcolor='#28282B',
                x=0.02,  # Adjust this value to shift the buttons to the right
                y=1.05,  # Adjust this value to shift the buttons vertically if needed
                xanchor='left'  # Anchor the buttons to the left of the specified x position
            ),
            type="date",
            showgrid=True, 
            gridcolor='#171515', 
            gridwidth=0.01
        ),                
        yaxis=dict(showgrid=False, gridcolor='#171515', gridwidth=0.01),
        font=dict(color='#ffffff')
    )

    return fig


def rewards_visualize(df):
    Number_to_color = generate_Number_to_color(sorted(df['Number'].unique()))
    fig = px.line(df, x="Timestamp", y="Rewards balance", color="Number", line_group="Number",
        custom_data=["Number", "Rewards balance", "Node", "PID"],
        labels={"Rewards balance": "Rewards Balance"},
        color_discrete_map=Number_to_color)

    fig = layout(fig, yaxis_title_text="Rewards", hover_template=custom_hovertemplate)                     

    output_html_path = os.path.join(datadir, "rewards_balance_plot.html")
    fig.write_html(output_html_path)

def memory_visualize(df):
    Number_to_color = generate_Number_to_color(sorted(df['Number'].unique()))
    fig = px.line(df, x="Timestamp", y="Memory used", color="Number", line_group="Number",
        custom_data=["Number", "Memory used", "Node", "PID"],
        labels={"Memory": "Memory Usage (MB)"},
        color_discrete_map=Number_to_color)


    fig = layout(fig, yaxis_title_text="Memory", hover_template=custom_hovertemplate)

    output_html_path = os.path.join(datadir, "memory_usage_plot.html")
    fig.write_html(output_html_path)   

def logarithmic_bubble_visualize(df):
    df["x"] = np.random.rand(len(df))
    df["y"] = np.random.rand(len(df))
    df["log_rewards"] = 2 * np.log(df["Rewards balance"] + 1)
    
    Number_to_color = generate_Number_to_color(sorted(df['Number'].unique()))

    fig = px.scatter(df, x="x", y="y", size="log_rewards", color="Number", hover_name="Node",
                 hover_data=["Number", "Rewards balance"],
                 labels={"log_rewards": "Rewards Balance"},
                 color_discrete_map=Number_to_color,
                 size_max=50)
    
    fig.update_traces(
        hovertemplate="Number: %{customdata[0]}<br>Rewards balance: %{customdata[1]:.9f}<extra></extra>",
        marker=dict(line=dict(width=0.5, color='#252526')),
        selector=dict(mode='markers+text')
    )
    
    fig.update_layout(
        hovermode='closest',
        paper_bgcolor='black',  # Black background
        plot_bgcolor='#070D0D',   # White plot area
        margin=dict(t=1, b=1, l=1, r=1, pad=2),  # Thin grey border effect
        xaxis=dict(showgrid=False, visible=False),
        yaxis=dict(showgrid=False, visible=False),
        legend_title_font_color='black',
        legend_font_color='black',
        hoverlabel=dict(bgcolor='black', font_color='white'),
        font=dict(size=11, color='black'),  # Matching font size and color
        showlegend=False
    )

    fig.update_traces(hovertemplate="Number: %{customdata[0]}<br>Rewards balance: %{customdata[1]:.9f}<extra></extra>")

    output_html_path = os.path.join(datadir, "bubble_rewards.html")
    fig.write_html(output_html_path) 

log_files = glob.glob(os.path.join(datadir, "resources*.log"))


def records_visualize(df):
    if 'Number' in df.columns and df['Number'].str.contains(':').all():
        df[['log_number', 'node_number']] = df['Number'].str.split(':', expand=True).astype(int)
        df = df.sort_values(['log_number', 'node_number'], ascending=[True, True])
        df = df.drop(['log_number', 'node_number'], axis=1)

    else:
        raise ValueError("Column 'Number' is missing or not in the expected format 'log_number:node_number'")

    # Prepare the 'Record Count' column
    df['Record Count'] = df['Records']

    # Remove duplicates, keeping the last entry per 'Number'
    df = df.drop_duplicates(subset='Number', keep='last')

    # Generate colors
    Number_to_color = generate_Number_to_color(sorted(df['Number'].unique()))

    # Create the bar plot
    fig = px.bar(
        df, 
        x="Number", 
        y="Record Count",
        color="Number",
        labels={"Record Count": "Record Count"},
        color_discrete_map=Number_to_color,
        opacity=1.0
    )
    
    fig.update_layout(
        showlegend=False,
        paper_bgcolor='black',  # Black background
        plot_bgcolor='#070D0D',   # White plot area
        margin=dict(t=1, b=1, l=1, r=1, pad=2),  # Thin grey border effect
        yaxis=dict(
            showgrid=False, 
            gridcolor='grey',  # Adjusted to match your HTML styling
            gridwidth=0.01,
        ),
        xaxis=dict(
            title="",  # Hides the x-axis title
            showticklabels=False  # Hides the x-axis tick labels
        ),
        font=dict(color='white')  # White font color
    )


    # Adding a range slider to the x-axis
    fig.update_xaxes(
        rangeslider_visible=True,
        rangeselector=dict(
            buttons=list([
                dict(count=1, label="1", step="all", stepmode="backward"),
                dict(count=6, label="6", step="all", stepmode="backward"),
                dict(step="all")
            ])
        )
    )

    # Adding a label for the range selector
    fig.add_annotation(
        x=0.5,
        y=-0.35,
        xref="paper",
        yref="paper",
        text="Range Selector",
        showarrow=False,
        font=dict(size=12, color="black"),
        align="center",
        bgcolor="white",
        bordercolor="black",
        borderwidth=1
    )

    output_html_path = os.path.join(datadir, "records.html")
    fig.write_html(output_html_path)


if not log_files:
    print("No log files found!")
    exit()

if __name__ == "__main__":
    line_df, bubble_df = combined_extract_data(log_files)
    rewards_visualize(line_df)
    memory_visualize(line_df)
    logarithmic_bubble_visualize(bubble_df)
    records_visualize(line_df)
    

    
