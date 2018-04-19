
library(ape)

t = read.nexus("data/onagraceae_final_map.tree")

to_drop = c("Rotala_ramosior", "Rotala_rotundifolia", "Rotala_indica", "Heimia_salicifolia", "Heimia_myrtifolia", "Heimia_montana",
           "Pemphis_acidula", "Lafoensia_acuminata", "Punica_granatum", "Galpinia_transvaalica", "Capuronia_madagascariensis",
           "Physocalymma_scaberrimum", "Cuphea_hyssopifolia", "Cuphea_appendiculata", "Cuphea_viscosissima",
           "Cuphea_carthagenensis", "Woodfordia_fruticosa", "Koehneria_madagascariensis", "Pleurophora_anomala", "Pehria_compacta",
           "Adenaria_floribunda", "Decodon_verticillatus", "Lythrum_maritimum", "Lythrum_salicaria", "Lythrum_junceum",
           "Lythrum_hyssopifolia", "Lythrum_borysthenicum", "Peplis_portula", "Lythrum_portula", "Lythrum_flagellare",
           "Lagerstroemia_speciosa", "Lagerstroemia_indica", "Duabanga_grandiflora", "Lagerstroemia_parviflora", "Duabanga_moluccana",
           "Trapa_natans", "Trapa_maximowiczii", "Sonneratia_caseolaris", "Sonneratia_alba", "Sonneratia_ovata", "Sonneratia_apetala", "Ammannia_coccinea",
           "Lawsonia_inermis", "Ammannia_baccifera", "Ammannia_latifolia", "Nesaea_aspera", "Ammannia_prieuriana", "Ammannia_robusta")
            
t = drop.tip(t, to_drop, rooted=TRUE)

write.tree(t, "data/onagraceae_final_map_trimmed.tree")
