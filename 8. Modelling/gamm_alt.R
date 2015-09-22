# Appendix - to remove maybe
# #### South Coast GAMM selection
# 
# SouthFull = uGamm(OtoWidth ~ s(Ages) + 
#                     LagFinFSLdat_AnnEsts +
#                     FSL_months_Feb +
#                     LagFSLdat_Annual +
#                     LagFSLdat_Spring +
#                     LagFSL_months_Oct+
#                     FinFSLdat_SummerDat +
#                     FinFSLdat_AutumnDat +
#                     LagFSL_months_Nov , random = ~(1|FishName), data = South)
# 
# 
# getCall(SouthFull)
# update(SouthFull) 
# a <- dredge(SouthFull) # takes around 4 minutes to run
# # Visualize the model selection table:
# par(mfrow = c(1,1),mar = c(3,5,6,4))
# plot(a)
# aa <- summary(model.avg(a, subset = delta <= 8))
# # export the data frame into excel
# write.csv(a, "South_dredge.csv")
# 
# 
# 
# #### West Coast GAMM selection
# 
# WestFull = uGamm(OtoWidth ~ s(Ages) + 
#                    WestSST_Annual +
#                    FinFSLdat_AnnEsts +
#                    FinWestSST_AnnEsts +
#                    WestSST_Spring +
#                    SST_West_Months_Oct+
#                    LagSST_West_Months_Nov +
#                    LagSST_West_Months_Dec +
#                    SST_West_Months_Jun , random = ~(1|FishName), data = West)
# 
# 
# getCall(WestFull)
# update(WestFull) 
# b <- dredge(WestFull) # takes around 4 minutes to run
# # Visualize the model selection table:
# par(mfrow = c(1,1),mar = c(3,5,6,4))
# plot(b)
# bb <- summary(model.avg(b, subset = delta <= 8))
# # export the data frame into excel
# write.csv(b, "West_dredge.csv")
