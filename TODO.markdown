# Add a discussion system

Discussion systems, like a forum, are kind of complicated.  There are 
actually a couple of different ways you could implement one, and each 
has its own strength.  You could have something more clearly like a 
forum--where there are topics and then all these subdiscussions.  Or you 
could have something more like Twitter conversations where there is just 
one stream of conversation.  Or you can have something like Gmail 
conversations, wheter there are threads but they kind of all appear at 
once (well, sort of).

I'm a fan of either the Twitter or the Gmail approach for this 
application.  The reason: simplicity.  The groups here are very small (5 
people), and I just don't think they're going to have lots of different, 
specific topics to cover.  They can just chat, and it can all be 
related.  For now, I'm going to start with a single timeline model.  
Then I can take it from there.

## What to do now?

I suppose I should get started by writing some cucumber features.  The 
basic idea is that if I'm signed on I can go and view the discussion and 
I can say something to contribute to the discussion.  That might be it.  
There will be other features eventually: you can get an email when there 
are comments, and so on.  But for now this is the basic deal: you can 
view and contribute to the conversation if you are logged in, you can't 
if you aren't.
