-- UNSUPPORTED

-- ans1(reviewerName,rating1,reviewDate,rating2,review,rating3,rating4,reviewer,title)
-- CONSTRUCT [reviewerName, rating1, reviewDate, rating2, review, rating3, rating4, reviewer, title] [review/URI("http://www4.wiwiss.fu-berlin.de/bizer/bsbm/v01/instances/dataFromRatingSite/Review{}_{}","7",rev_reviewIdm4), reviewer/URI("http://www4.wiwiss.fu-berlin.de/bizer/bsbm/v01/instances/dataFromRatingSite/Reviewer{}",rev_reviewer_personIdm7), rating1/http://www.w3.org/2001/XMLSchema#integer(rev_rating1m11), rating2/http://www.w3.org/2001/XMLSchema#integer(rev_rating2m12), rating3/http://www.w3.org/2001/XMLSchema#integer(rev_rating3m6), rating4/http://www.w3.org/2001/XMLSchema#integer(rev_rating4m10), title/http://www.w3.org/2001/XMLSchema#string(rev_titlem1), reviewDate/http://www.w3.org/2001/XMLSchema#date(rev_datem39)]
--    LJ EQ(rev_reviewIdm4,rev_reviewIdm4f5)
--       LJ EQ(rev_reviewIdm4,rev_reviewIdm4f6)
--          LJ EQ(rev_reviewIdm4,rev_reviewIdm4f7)
--             LJ EQ(rev_reviewIdm4,rev_reviewIdm4f8)
--                FILTER AND(AND(AND(IS_NOT_NULL(rev_reviewer_personIdm7),IS_NOT_NULL(reviewerName)),IS_NOT_NULL(rev_reviewIdm4)),EQ(rev_reviewIdm4,rev_reviewIdm4f9))
--                   STRICT-FLATTEN reviewsf11 -> flat-products-reviews(reviews_idxm7,rev_reviewIdm4f9,rev_datem7,rev_titlem7,rev_contentm7,rev_rating1m7,rev_rating2m7,rev_rating3m7,rev_rating4m7,rev_reviewer_personIdm7,reviewerName,rev_reviewer_countrym7)
--                      FILTER IS_NOT_NULL(rev_datem39)
--                         STRICT-FLATTEN reviewsf11 -> flat-products-reviews(reviews_idxm39,rev_reviewIdm4,rev_datem39,rev_titlem39,rev_contentm39,rev_rating1m39,rev_rating2m39,rev_rating3m39,rev_rating4m39,rev_reviewer_personIdm39,rev_reviewer_namem39,rev_reviewer_countrym39)
--                            FILTER IS_NOT_NULL(rev_contentm9)
--                               STRICT-FLATTEN reviewsf11 -> flat-products-reviews(reviews_idxm9,rev_reviewIdm4,rev_datem9,rev_titlem9,rev_contentm9,rev_rating1m9,rev_rating2m9,rev_rating3m9,rev_rating4m9,rev_reviewer_personIdm9,rev_reviewer_namem9,rev_reviewer_countrym9)
--                                  FILTER IS_NOT_NULL(rev_titlem1)
--                                     STRICT-FLATTEN reviewsf11 -> flat-products-reviews(reviews_idxm1,rev_reviewIdm4,rev_datem1,rev_titlem1,rev_contentm1,rev_rating1m1,rev_rating2m1,rev_rating3m1,rev_rating4m1,rev_reviewer_personIdm1,rev_reviewer_namem1,rev_reviewer_countrym1)
--                                        STRICT-FLATTEN reviewsf11 -> flat-products-reviews(reviews_idxm4,rev_reviewIdm4,rev_datem4,rev_titlem4,rev_contentm4,rev_rating1m4,rev_rating2m4,rev_rating3m4,rev_rating4m4,rev_reviewer_personIdm4,rev_reviewer_namem4,rev_reviewer_countrym4)
--                                           FILTER EQ(f4,"7")
--                                              EXTENSIONAL products(f4,producer_producerIdf8,productNamef9,type_typeIdf7,properties_numeric1f26,properties_numeric2f25,properties_numeric3f24,properties_numeric4f23,properties_numeric5f22,properties_numeric6f20,properties_textual1f18,properties_textual2f19,properties_textual3f14,properties_textual4f15,properties_textual5f16,properties_textual6f17,commentf28,producer_namef27,producer_countryf21,producer_homepagef29,type_labelf12,featuresf10,offersf13,reviewsf11)
--                FILTER AND(IS_NOT_NULL(rev_rating1m11),IS_NOT_NULL(rev_reviewIdm4f8))
--                   STRICT-FLATTEN reviews -> flat-products-reviews(reviews_idxm11,rev_reviewIdm4f8,rev_datem11,rev_titlem11,rev_contentm11,rev_rating1m11,rev_rating2m11,rev_rating3m11,rev_rating4m11,rev_reviewer_personIdm11,rev_reviewer_namem11,rev_reviewer_countrym11)
--                      FILTER EQ(f3,"7")
--                         EXTENSIONAL products(f3,producer_producerId,productName,type_typeId,properties_numeric1,properties_numeric2,properties_numeric3,properties_numeric4,properties_numeric5,properties_numeric6,properties_textual1,properties_textual2,properties_textual3,properties_textual4,properties_textual5,properties_textual6,comment,producer_name,producer_country,producer_homepage,type_label,features,offers,reviews)
--             FILTER AND(IS_NOT_NULL(rev_rating2m12),IS_NOT_NULL(rev_reviewIdm4f7))
--                STRICT-FLATTEN reviewsf4 -> flat-products-reviews(reviews_idxm12,rev_reviewIdm4f7,rev_datem12,rev_titlem12,rev_contentm12,rev_rating1m12,rev_rating2m12,rev_rating3m12,rev_rating4m12,rev_reviewer_personIdm12,rev_reviewer_namem12,rev_reviewer_countrym12)
--                   FILTER EQ(f2,"7")
--                      EXTENSIONAL products(f2,producer_producerIdf1,productNamef2,type_typeIdf0,properties_numeric1f19,properties_numeric2f18,properties_numeric3f17,properties_numeric4f16,properties_numeric5f15,properties_numeric6f13,properties_textual1f11,properties_textual2f12,properties_textual3f7,properties_textual4f8,properties_textual5f9,properties_textual6f10,commentf21,producer_namef20,producer_countryf14,producer_homepagef22,type_labelf5,featuresf3,offersf6,reviewsf4)
--          FILTER AND(IS_NOT_NULL(rev_rating3m6),IS_NOT_NULL(rev_reviewIdm4f6))
--             STRICT-FLATTEN reviewsf5 -> flat-products-reviews(reviews_idxm6,rev_reviewIdm4f6,rev_datem6,rev_titlem6,rev_contentm6,rev_rating1m6,rev_rating2m6,rev_rating3m6,rev_rating4m6,rev_reviewer_personIdm6,rev_reviewer_namem6,rev_reviewer_countrym6)
--                FILTER EQ(f1,"7")
--                   EXTENSIONAL products(f1,producer_producerIdf2,productNamef3,type_typeIdf1,properties_numeric1f20,properties_numeric2f19,properties_numeric3f18,properties_numeric4f17,properties_numeric5f16,properties_numeric6f14,properties_textual1f12,properties_textual2f13,properties_textual3f8,properties_textual4f9,properties_textual5f10,properties_textual6f11,commentf22,producer_namef21,producer_countryf15,producer_homepagef23,type_labelf6,featuresf4,offersf7,reviewsf5)
--       FILTER AND(IS_NOT_NULL(rev_rating4m10),IS_NOT_NULL(rev_reviewIdm4f5))
--          STRICT-FLATTEN reviewsf6 -> flat-products-reviews(reviews_idxm10,rev_reviewIdm4f5,rev_datem10,rev_titlem10,rev_contentm10,rev_rating1m10,rev_rating2m10,rev_rating3m10,rev_rating4m10,rev_reviewer_personIdm10,rev_reviewer_namem10,rev_reviewer_countrym10)
--             FILTER EQ(f0,"7")
--                EXTENSIONAL products(f0,producer_producerIdf3,productNamef4,type_typeIdf2,properties_numeric1f21,properties_numeric2f20,properties_numeric3f19,properties_numeric4f18,properties_numeric5f17,properties_numeric6f15,properties_textual1f13,properties_textual2f14,properties_textual3f9,properties_textual4f10,properties_textual5f11,properties_textual6f12,commentf23,producer_namef22,producer_countryf16,producer_homepagef24,type_labelf7,featuresf5,offersf8,reviewsf6)
--
-- ORDER BY DESC(?reviewDate) LIMIT 20