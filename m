From: Ulrich Hecht <ulrich.hecht@gmail.com>
Date: Tue, 30 Jul 2013 17:57:26 +0000
Subject: [RFC 4/5] arm: boot: kzm9g: blink LEDs and check if DRAM works
Message-Id: <1375207047-8655-5-git-send-email-ulrich.hecht@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This is test code that shows the progress of kernel decompression and
does a quick DRAM test:

- all LEDs on: start of decompress_kernel()
- LED 1 off: DRAM test. Usually the system hangs here; if it doesn't it
will most often report an incorrect read by blinking out the address and
value read nibble by nibble through the LEDs.
- LED 2 off: start of kernel decompression
- LED 3 off: end of kernel decompression; if the decompressor has returned
an error, LED 1 will be turned back on.
- all LEDs off: end of decompress_kernel()

The likelihood of a hang is greatly reduced by inserting code between DRAM
writes, e.g. by blinking an LED. This also eliminates readback errors.
---
 arch/arm/boot/compressed/misc.c |  123 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 121 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/compressed/misc.c b/arch/arm/boot/compressed/misc.c
index 31bd43b..0c54a3d 100644
--- a/arch/arm/boot/compressed/misc.c
+++ b/arch/arm/boot/compressed/misc.c
@@ -129,6 +129,81 @@ asmlinkage void __div0(void)
 
 extern int do_decompress(u8 *input, int len, u8 *output, void (*error)(char *x));
 
+static void led_setup(void) {
+	volatile unsigned char *led_cr;
+	led_cr = (void*)0xe6050014;
+	led_cr[0] = led_cr[1] = led_cr[2] = led_cr[3] = 0x10;
+}
+static void led_set(int n, int on) {
+	volatile unsigned int *led_dxr;
+	if (on) {
+		led_dxr = (void*)0xe6074200;
+		led_dxr[0] = 0x100000 << n;
+	}
+	else {
+		led_dxr = (void*)0xe6074100;
+		led_dxr[0] = 0x100000 << n;
+	}
+}
+
+static void led_delay(int n)
+{
+	n *= 1000000;
+	int i = 0;
+	for (i = 0; i < n; i++) {
+		asm("nop");
+	}
+}
+
+static void morse_bits(unsigned int bits)
+{
+#define DEL 200
+	led_setup();
+	led_set(0, 0);
+	led_set(1, 0);
+	led_set(2, 0);
+	led_set(3, 0);
+	led_delay(DEL);
+	led_set(0, 1);
+	led_set(1, 1);
+	led_set(2, 1);
+	led_set(3, 1);
+	led_delay(DEL / 2);
+	led_set(0, 0);
+	led_set(1, 0);
+	led_set(2, 0);
+	led_set(3, 0);
+	led_delay(DEL);
+	int i;
+	for (i = 28; i >= 0; i -= 4) {
+		int nibble = bits >> i;
+		led_set(0, 0);
+		led_set(1, 0);
+		led_set(2, 0);
+		led_set(3, 0);
+		led_delay(DEL / 2);
+		led_set(0, 1);
+		led_set(1, 1);
+		led_set(2, 1);
+		led_set(3, 1);
+		led_delay(DEL / 4);
+		led_set(0, 0);
+		led_set(1, 0);
+		led_set(2, 0);
+		led_set(3, 0);
+		led_delay(DEL / 2);
+		led_set(0, nibble & 1);
+		led_set(1, nibble & 2);
+		led_set(2, nibble & 4);
+		led_set(3, nibble & 8);
+		led_delay(DEL * 8);
+	}
+	led_set(0, 0);
+	led_set(1, 0);
+	led_set(2, 0);
+	led_set(3, 0);
+}
+
 
 void
 decompress_kernel(unsigned long output_start, unsigned long free_mem_ptr_p,
@@ -142,13 +217,57 @@ decompress_kernel(unsigned long output_start, unsigned long free_mem_ptr_p,
 	free_mem_end_ptr	= free_mem_ptr_end_p;
 	__machine_arch_type	= arch_id;
 
+	led_setup();
+	//morse_bits((unsigned int)output_data);
+	led_set(0, 1);
+	led_set(1, 1);
+	led_set(2, 1);
+	led_set(3, 1);
+
+	led_set(0, 0);
+#if 1
+	int i;
+	volatile unsigned int *dram = output_data;// + 0x10000000;
+#define DRAM_TEST_SIZE  10000000
+	for (i = 0; i < DRAM_TEST_SIZE; i++)
+	{
+		//led_set(0, i & 32768);
+		//led_set(1, i & 131072);
+		dram[i] = 0xd00df00d;
+		dram[i] = 0xcafebabe + i;
+	}
+	led_set(0, 0);
+	led_set(1, 1);
+#if 1
+	for (i = 0; i < DRAM_TEST_SIZE; i++) {
+		//led_set(2, i & 32768);
+		//led_set(3, i & 65536);
+#if 1
+		if (dram[i] != 0xcafebabe + i) {
+			//led_set(0, 1);
+			morse_bits((unsigned int)&dram[i]);
+			morse_bits(dram[i]);
+		}
+#endif
+	}
+	led_set(2, 1);
+	led_set(3, 1);
+#endif
+#endif
+	
 	arch_decomp_setup();
 
+	led_set(1, 0);
 	putstr("Uncompressing Linux...");
 	ret = do_decompress(input_data, input_data_end - input_data,
 			    output_data, error);
-	if (ret)
+	led_set(2, 0);
+	if (ret) {
 		error("decompressor returned an error");
-	else
+		led_set(0, 1);
+	}
+	else {
 		putstr(" done, booting the kernel.\n");
+	}
+	led_set(3, 0);
 }
-- 
1.7.10.4

