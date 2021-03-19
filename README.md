# News2Day

News2Day provides the top US headlines arranged by date.
The DetailVC includes a scrollable content view of each news article. 
The article content is limited to 50 characters as I used the free News API. 
In light of this a safari icon was added in the navigation bar that takes you to a Webview of the article.
Each collection view cell (ArticleCell) includes a 0.6 second curveEaseOut animation when scrolling, along with a cache manager 
for the images within the newsfeed.
News2Day supports dark mode and dynamic text sizing along with landscape orientation on both iPhone and iPad.
