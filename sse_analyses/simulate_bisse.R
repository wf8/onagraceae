
library(diversitree)
library(ape)
set.seed(1234)

# simulate tree and character under BiSSE

num_reps = 100

# diversification rates for hidden states A and B
lambda_A = 1.0 
lambda_B = 2.0
mu_A = 0.4 
mu_B = 0.1

# rate of change between hidden states A and B
delta_AB = 0.1
delta_BA = 0.1

# start in hidden state A
start_state = 0

# root age
root_age = 5

# parameters = λ0, λ1, µ0, µ1, q01, q10
pars = c(lambda_A, lambda_B, mu_A, mu_B, delta_AB, delta_BA)

cat("rep", "num_taxa", "percent_A", "\n", file="sim_data/stats.csv", append=FALSE, sep=",")
for (i in 1:num_reps) {

    while (TRUE) {

        # simulate tree 
        phy = tree.bisse(pars, max.t=root_age, x0=start_state)

        if (is.null(phy) == FALSE) {

            # trim the tree so only 45% of the extant tips sampled (like empirical tree)
            num_taxa = length(phy$tip.label)
            tips = phy$tip.label
            to_drop = sample(tips, num_taxa * 0.45)
            trimmed_tree = drop.tip(phy, to_drop)
            
            # get info about the remaining tips
            num_taxa = length(phy$tip.label)
            states = phy$tip.state
            percent_A = length(phy$tip.state[ phy$tip.state==0 ])/length(phy$tip.state)

            # sample another tree if this one doesn't have between 100 and 200 tips
            # and if the proportion of tips in state A is not between 0.2 and 0.5
            if (100 < num_taxa && num_taxa < 200 && 0.2 < percent_A && percent_A < 0.5)
                break
        }
    }

    # write some stats about this simulation replicate
    cat(i, num_taxa, percent_A, "\n", file="sim_data/stats.csv", append=TRUE, sep=",")

    # write the tree to a newick file
    write.tree(trimmed_tree, file=paste("sim_data/", i, ".tree", sep=""))

    # now write tip data file
    a = FALSE
    for (j in 1:num_taxa) {
        cat(names(states[j]), states[j], "\n", file=paste("sim_data/", i, ".csv", sep=""), append=a, sep=",")
        a = TRUE
    }
}
