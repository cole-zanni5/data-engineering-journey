import pandas as pd
from pathlib import Path

# Folder containing raw CSVs
DATA_DIR = Path("C:/Users/colez/Documents/GitHub/data-engineering-journey/python/data/raw")

# List of QB CSV files
files = ["qb_2023.csv", "qb_2024.csv", "qb_2025.csv"]

dfs = []

for file in files:
    df = pd.read_csv(Path(DATA_DIR, file))               # Read CSV
    season = file.split("_")[1].split(".")[0]          # Extract season from filename
    df["season"] = int(season)                         # Add season column
    dfs.append(df)                                     # Add DataFrame to list

qb_all = pd.concat(dfs, ignore_index=True)            # Combine all seasons
qb_all.columns = qb_all.columns.str.lower().str.replace(" ", "_")  # Standardize column names

# Save cleaned data
qb_all.to_csv(
    Path("C:/Users/colez/Documents/GitHub/data-engineering-journey/python/data/clean/qb_clean.csv"),
    index=False
)

print("Data cleaning complete. Cleaned data saved to qb_clean.csv")
