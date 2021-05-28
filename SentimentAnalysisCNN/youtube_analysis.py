import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import statsmodels.api as sm

youtube_data = pd.read_csv('video_result.csv')

# plt.figure()
# hist1, edges1 = np.histogram(youtube_data.viewCount)
# plt.bar(edges1[:-1], hist1, width=edges1[1:]-edges1[:-1])

print(youtube_data.corr())

plt.scatter(youtube_data.viewCount, youtube_data.likeCount)

X = youtube_data.viewCount
y = youtube_data.likeCount
X = sm.add_constant(X)

lr_model = sm.OLS(y, X).fit()

print(lr_model.summary())

X_prime = np.linspace(X.viewCount.min(), X.viewCount.max(), 100)
X_prime = sm.add_constant(X_prime)

y_hat = lr_model.predict(X_prime) # predicted value
plt.scatter(X.viewCount, y)
plt.xlabel("View Count")
plt.ylabel("Like Count")
plt.plot(X_prime[:,1], y_hat)