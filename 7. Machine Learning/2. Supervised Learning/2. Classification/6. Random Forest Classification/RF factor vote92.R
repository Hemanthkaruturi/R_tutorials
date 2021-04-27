get_vote_df = function(df = vote92) {
    
    df$dem          = factor(df$dem)
    df$rep          = factor(df$rep)
    df$female       = factor(df$female)
    df$persfinace   = factor(df$persfinance, 
                             labels = c('worse','same','better') )
    df$natlecon     = factor(df$natlecon,
                             labels = c('worse','same','better') )
    
    return(df)
    
}