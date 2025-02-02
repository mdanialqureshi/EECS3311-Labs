/*
 * Class DATE_TIME_VALIDITY_CHECKER
 */

#include "eif_macros.h"


#ifdef __cplusplus
extern "C" {
#endif

static const EIF_TYPE_INDEX egt_0_999 [] = {0xFF01,232,0xFFFF};
static const EIF_TYPE_INDEX egt_1_999 [] = {0xFF01,245,998,0xFFFF};
static const EIF_TYPE_INDEX egt_2_999 [] = {0xFF01,998,0xFFFF};
static const EIF_TYPE_INDEX egt_3_999 [] = {0,0xFFFF};
static const EIF_TYPE_INDEX egt_4_999 [] = {0,0xFFFF};
static const EIF_TYPE_INDEX egt_5_999 [] = {0xFF01,998,0xFFFF};
static const EIF_TYPE_INDEX egt_6_999 [] = {0xFF01,998,0xFFFF};
static const EIF_TYPE_INDEX egt_7_999 [] = {0,0xFFFF};
static const EIF_TYPE_INDEX egt_8_999 [] = {0xFF01,15,0xFFFF};
static const EIF_TYPE_INDEX egt_9_999 [] = {0xFF01,232,0xFFFF};
static const EIF_TYPE_INDEX egt_10_999 [] = {0xFF01,232,0xFFFF};
static const EIF_TYPE_INDEX egt_11_999 [] = {0xFF01,25,0xFFFF};
static const EIF_TYPE_INDEX egt_12_999 [] = {0xFF01,998,0xFFFF};
static const EIF_TYPE_INDEX egt_13_999 [] = {0xFF01,961,0xFFFF};
static const EIF_TYPE_INDEX egt_14_999 [] = {0xFF01,232,0xFFFF};
static const EIF_TYPE_INDEX egt_15_999 [] = {0xFF01,232,0xFFFF};
static const EIF_TYPE_INDEX egt_16_999 [] = {0xFF01,340,0xFF01,232,0xFFFF};
static const EIF_TYPE_INDEX egt_17_999 [] = {0xFF01,340,0xFF01,232,0xFFFF};
static const EIF_TYPE_INDEX egt_18_999 [] = {0xFF01,340,0xFF01,232,0xFFFF};
static const EIF_TYPE_INDEX egt_19_999 [] = {0xFF01,340,0xFF01,232,0xFFFF};
static const EIF_TYPE_INDEX egt_20_999 [] = {0xFF01,556,221,0xFFFF};
static const EIF_TYPE_INDEX egt_21_999 [] = {0xFF01,159,0xFFFF};
static const EIF_TYPE_INDEX egt_22_999 [] = {0xFF01,232,0xFFFF};
static const EIF_TYPE_INDEX egt_23_999 [] = {0xFF01,232,0xFFFF};


static const struct desc_info desc_999[] = {
	{EIF_GENERIC(NULL), 0xFFFFFFFF, 0xFFFFFFFF},
	{EIF_GENERIC(egt_0_999), 0, 0xFFFFFFFF},
	{EIF_GENERIC(egt_1_999), 1, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x0191 /*200*/), 2, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x0191 /*200*/), 3, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x0191 /*200*/), 4, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x0191 /*200*/), 5, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x0191 /*200*/), 6, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x0191 /*200*/), 7, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x0191 /*200*/), 8, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x0191 /*200*/), 9, 0xFFFFFFFF},
	{EIF_GENERIC(egt_2_999), 10, 0xFFFFFFFF},
	{EIF_GENERIC(NULL), 11, 0xFFFFFFFF},
	{EIF_GENERIC(NULL), 12, 0xFFFFFFFF},
	{EIF_GENERIC(egt_3_999), 13, 0xFFFFFFFF},
	{EIF_GENERIC(egt_4_999), 14, 0xFFFFFFFF},
	{EIF_GENERIC(egt_5_999), 15, 0xFFFFFFFF},
	{EIF_GENERIC(egt_6_999), 16, 0xFFFFFFFF},
	{EIF_GENERIC(egt_7_999), 17, 0xFFFFFFFF},
	{EIF_GENERIC(NULL), 18, 0xFFFFFFFF},
	{EIF_GENERIC(NULL), 19, 0xFFFFFFFF},
	{EIF_GENERIC(egt_8_999), 20, 0xFFFFFFFF},
	{EIF_GENERIC(egt_9_999), 21, 0xFFFFFFFF},
	{EIF_GENERIC(egt_10_999), 22, 0xFFFFFFFF},
	{EIF_GENERIC(NULL), 23, 0xFFFFFFFF},
	{EIF_GENERIC(egt_11_999), 24, 0xFFFFFFFF},
	{EIF_GENERIC(NULL), 25, 0xFFFFFFFF},
	{EIF_GENERIC(NULL), 26, 0xFFFFFFFF},
	{EIF_GENERIC(NULL), 27, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x07CD /*998*/), 28, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x01C7 /*227*/), 29, 0xFFFFFFFF},
	{EIF_GENERIC(egt_12_999), 30, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x01BB /*221*/), 13756, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x01BB /*221*/), 13757, 0xFFFFFFFF},
	{EIF_GENERIC(egt_13_999), 13754, 0xFFFFFFFF},
	{EIF_GENERIC(egt_14_999), 13755, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x01BB /*221*/), 13783, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x01BB /*221*/), 13784, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x01BB /*221*/), 13785, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x01BB /*221*/), 13786, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x01BB /*221*/), 13787, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x01BB /*221*/), 13788, 0xFFFFFFFF},
	{EIF_GENERIC(egt_15_999), 13789, 0xFFFFFFFF},
	{EIF_GENERIC(egt_16_999), 13790, 0xFFFFFFFF},
	{EIF_GENERIC(egt_17_999), 13791, 0xFFFFFFFF},
	{EIF_GENERIC(egt_18_999), 13792, 0xFFFFFFFF},
	{EIF_GENERIC(egt_19_999), 13793, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x0191 /*200*/), 13794, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x0191 /*200*/), 13795, 0xFFFFFFFF},
	{EIF_GENERIC(egt_20_999), 13796, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x01BB /*221*/), 14002, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x01BB /*221*/), 14003, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x01BB /*221*/), 14004, 0xFFFFFFFF},
	{EIF_GENERIC(NULL), 13987, 0xFFFFFFFF},
	{EIF_GENERIC(NULL), 13988, 0xFFFFFFFF},
	{EIF_GENERIC(NULL), 13989, 0xFFFFFFFF},
	{EIF_GENERIC(NULL), 13990, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x01BB /*221*/), 13808, 0xFFFFFFFF},
	{EIF_GENERIC(NULL), 13993, 0xFFFFFFFF},
	{EIF_GENERIC(egt_21_999), 6565, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x01BB /*221*/), 14005, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x01BB /*221*/), 14006, 4},
	{EIF_GENERIC(NULL), 13991, 0xFFFFFFFF},
	{EIF_GENERIC(NULL), 13992, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x01BB /*221*/), 13994, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x01BB /*221*/), 13995, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x01BB /*221*/), 13996, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x01BB /*221*/), 13997, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x01BB /*221*/), 13998, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x01BB /*221*/), 13999, 0xFFFFFFFF},
	{EIF_GENERIC(egt_22_999), 14000, 0xFFFFFFFF},
	{EIF_GENERIC(NULL), 14001, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x0191 /*200*/), 15274, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x0191 /*200*/), 15275, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x0191 /*200*/), 15276, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x0191 /*200*/), 15277, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x0191 /*200*/), 15278, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x0191 /*200*/), 15279, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x0191 /*200*/), 15280, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x01BB /*221*/), 13758, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x01BB /*221*/), 13759, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x01BB /*221*/), 13760, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x01BB /*221*/), 13761, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x01BB /*221*/), 13762, 0xFFFFFFFF},
	{EIF_GENERIC(egt_23_999), 13763, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x01BB /*221*/), 13769, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x01BB /*221*/), 13770, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x01BB /*221*/), 13771, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x0197 /*203*/), 13774, 0xFFFFFFFF},
	{EIF_GENERIC(NULL), 13780, 0xFFFFFFFF},
	{EIF_GENERIC(NULL), 13781, 0xFFFFFFFF},
	{EIF_GENERIC(NULL), 13782, 0xFFFFFFFF},
	{EIF_GENERIC(NULL), 13779, 0xFFFFFFFF},
	{EIF_GENERIC(NULL), 13778, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x0197 /*203*/), 13772, 8},
	{EIF_NON_GENERIC(0x01BB /*221*/), 13773, 0},
	{EIF_NON_GENERIC(0x01BB /*221*/), 13775, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x01BB /*221*/), 13776, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x01BB /*221*/), 13777, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x01BB /*221*/), 13764, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x01BB /*221*/), 13765, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x01BB /*221*/), 13766, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x01BB /*221*/), 13767, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x01BB /*221*/), 13768, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x0191 /*200*/), 15241, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x0191 /*200*/), 15242, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x0191 /*200*/), 15243, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x0191 /*200*/), 15324, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x0191 /*200*/), 15325, 0xFFFFFFFF},
	{EIF_NON_GENERIC(0x0191 /*200*/), 15326, 0xFFFFFFFF},
};
void Init999(void)
{
	IDSC(desc_999, 0, 998);
	IDSC(desc_999 + 1, 1, 998);
	IDSC(desc_999 + 32, 422, 998);
	IDSC(desc_999 + 36, 410, 998);
	IDSC(desc_999 + 50, 418, 998);
	IDSC(desc_999 + 58, 305, 998);
	IDSC(desc_999 + 60, 404, 998);
	IDSC(desc_999 + 72, 405, 998);
	IDSC(desc_999 + 79, 421, 998);
	IDSC(desc_999 + 85, 420, 998);
	IDSC(desc_999 + 94, 407, 998);
	IDSC(desc_999 + 104, 408, 998);
	IDSC(desc_999 + 107, 416, 998);
}


#ifdef __cplusplus
}
#endif
