import pandas as pd
import matplotlib.pyplot as plt

# Load cleaned data
qb = pd.read_csv("C:/Users/colez/Documents/GitHub/data-engineering-journey/python/data/clean/qb_clean.csv")

qb.head(10)
qb.columns

# qb avgs
qb_filtered = qb[qb["att"] >= 400]  # Filter QBs with at least 400 attempts
avg_yds = qb_filtered.groupby("season")["yds"].mean().round(1).reset_index()
avg_tds = qb_filtered.groupby("season")["td"].mean().round(1).reset_index()
avg_int = qb_filtered.groupby("season")["int"].mean().round(1).reset_index()
avg_yds, avg_tds, avg_int

#plt.plot(avg_tds["season"], avg_tds["td"], marker='o', label='Average Tocuchdowns')
#plt.plot(avg_int["season"], avg_int["int"], marker='o', label='Average Interceptions')
# Plot average passing yards
plt.figure(figsize=(8, 6))
plt.plot(avg_yds["season"], avg_yds["yds"], marker='o', label='Average Yards')
plt.title("Average QB Passing Yards by Season (Min 400 Attempts))")
plt.xlabel("Season")
plt.ylabel("Average Passing Yards")
plt.xticks(avg_yds["season"])
plt.legend()
plt.grid()
plt.show()

# Plot average touchdowns
plt.figure(figsize=(8, 6))
plt.plot(avg_tds["season"], avg_tds["td"], marker='o', color='green', label='Average Touchdowns')
plt.title("Average QB Touchdowns by Season (Min 400 Attempts))")
plt.xlabel("Season")
plt.ylabel("Average Touchdowns")
plt.xticks(avg_tds["season"])
plt.legend()
plt.grid()
plt.show()

# Plot average interceptions
plt.figure(figsize=(8, 6))
plt.plot(avg_int["season"], avg_int["int"], marker='o', color='red', label='Average Interceptions')
plt.title("Average QB Interceptions by Season (Min 400 Attempts))")
plt.xlabel("Season")
plt.ylabel("Average Interceptions")
plt.xticks(avg_int["season"])
plt.legend()
plt.grid()
plt.show()

# Top 5 QBs by season
top_qbs = qb_filtered.sort_values(by=["season", "yds"], ascending=[True, False]).groupby("season").head(5)
top_qbs[['season', 'player', 'yds', 'td', 'int']]
for season in top_qbs["season"].unique():
    print(f"\nTop 5 QBs in {season} by Yards:")
    display(top_qbs[top_qbs["season"] == season][['player', 'yds', 'td', 'int']].reset_index(drop=True))


