#Create punctuation vector
punct <- unlist(strsplit('[]\\?!\"\'#$%&(){}+*/:;,._`|~\\[<=>@\\^-]', NULL))
#Create vector of all usable characters
allvals <- c(0:9, LETTERS, letters, punct, " ")

#Creates a random string (not pasted)
randomString <- function(n) { 
      return(sample(allvals, n, replace = T))
}

#Hamming distance between 2 strings (not pasted)
hamming <- function(string1, string2) {
      return(sum(!(string1 == string2)))
}

#Tournament method for reproduction
tournament <- function(contenders) {
      if(contenders[[1]]$fitness > contenders[[2]]$fitness) {
            return(contenders[[2]]$string)
      } else if(contenders[[1]]$fitness < contenders[[2]]$fitness) {
            return(contenders[[1]]$string)
      } else return(contenders[[sample(1:2, 1)]]$string)
}

#1 point cross-over
reproduce <- function(parent1, parent2) {
      position <- sample(1:(length(target_v)-1), 1)
      child1 <- c(parent1[1:position], parent2[(position+1):length(target_v)])
      child2 <- c(parent2[1:position], parent1[(position+1):length(target_v)])
      return(c(list(child1), list(child2)))
}

#Mutation: specific number of changes
mutate <- function(ninja) {
      mut <- length(ninja)
      ninja[sample(1:mut, ceiling(mut*mut_rate), replace = T)] <- sample(allvals, ceiling(mut * mut_rate), replace = T)
      return(list(ninja))
}


genetic <- function(target, n = 50, elite_per = 0.2, rep_per = 0.7, mut_rate = 0.2, seed = 1) {
	  #Start counting the time
      ptm <- proc.time()
	  #Set everything
      set.seed(seed)
      elite_n = ceiling(n * elite_per)
      rep_n = ceiling(n * rep_per)
      pop <- list()
      target_v <- unlist(strsplit(target, NULL))
      best_fit <- 14
      gen <- 0
      
      #Generate first population
      while(length(pop) < n) {
            pop <- c(pop, list(randomString(length(target_v))))
      }
      
      #Calculate fitness
      for(i in 1:n) {
            pop[[i]] <- list(string = pop[[i]], fitness = hamming(target_v, pop[[i]]))
      }
      
      while(best_fit != 0) {
            gen <- gen + 1
            #Reproduction: tournament method, 1 point crossover
            children <- list()
            while(length(children) < rep_n) {
             children <- c(children, reproduce(tournament(pop[sample(1:n, 2)]), tournament(pop[sample(1:n, 2)])))
            }
            
            
            #Mutation
            mut_n = n - length(children) - elite_n
            turtles <- list()
            while(length(turtles) < mut_n) {
             turtles <- c(turtles, mutate(pop[[sample(1:n, 1)]]$string))
            }
            
            
            #Keep the elite
            fitness <- c()
            for(i in 1:n) {
                  fitness <- c(fitness, pop[[i]][[2]]) 
            }
            elite <- pop[sort(fitness, index.return = T)$ix[1:elite_n]]
            
			#Join children and turtles, calculate their fit
            pop <- c(children, turtles)
            for(i in 1:length(pop)) {
                  pop[[i]] <- list(string = pop[[i]], fitness = hamming(target_v, pop[[i]]))
            }
            
			#Put the elite with the rest of the population
            pop <- c(pop, elite)
            
            #Check best fit
            fitness <- c()
            for(i in 1:n) {
                  fitness <- c(fitness, pop[[i]][[2]]) 
            }
            
			#Update best fit and print to console
            if(min(fitness) < best_fit) {
                  best_fit <- min(fitness)
                  cat(paste0("Gen: ", gen), "|", paste0("Fitness: ", best_fit), "|", 
                      paste0(pop[[which.min(fitness)]]$string, collapse = ""), "\n", sep = "\t")
            }
            
            
      }
	  #Finish by printing elapsed time
      cat("\n", "Elapsed time: ", proc.time()[3] - ptm[3], " seconds.", sep = "")    
}
