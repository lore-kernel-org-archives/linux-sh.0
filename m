From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 09 Jan 2014 12:21:13 +0000
Subject: Re: lager - non-booting latest horms' devel branch
Message-Id: <CAMuHMdWrg+ShPBU3wS=+GKNGgE4-=NBGeK8EP4QoTCuaxbJYaw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <52CE8BC0.7060306@codethink.co.uk>
In-Reply-To: <52CE8BC0.7060306@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ben,

On Thu, Jan 9, 2014 at 12:45 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> I am using the devel branch from Simon Horms' git tree, SHA1
> 3da593ea7d797d9f59bd6ed1ee629fab681d7a23 and not seeing a
> boot when using the multi arch defconfig and device-tree.
>
> The board does not produce any console output so I am not
> sure what is going on. Has anyone else had issues with using
> the fdt-only boot?

I'm using Koelsch (not Lager), but usually the non-reference version as I
need Ethernet for NFS root.
The DT-version does boot for me until mounting root.

Are you using an initramfs? I noticed the kernel crashes early when using
a non-trivial initramfs:

    Error: unrecognized/unsupported machine ID (r1 = 0x41915083).

    Available machine support:

    ID (hex)        NAME
    ffffffff        Generic R8A7791 (Flattened Device Tree)
    ffffffff        koelsch

    Please check your kernel config and/or bootloader.

Apparently the device tree gets overwritten in memory. I tried loading the
DTB at a different address, but that didn't help. I didn't have more time
to investigate, though.

FYI, I'm using the following patch to capture early kernel messages in RAM.
After a reset, look up the addres of big_buffer[] in System.map, and
inspect it from U-Boot to retrieve the messages (translate from 0xc0000000
to 0x40000000).

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index be7c86bae576..609bccc002ca 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -46,6 +46,7 @@
 #include <linux/irq_work.h>
 #include <linux/utsname.h>

+#include <asm/cacheflush.h>
 #include <asm/uaccess.h>

 #define CREATE_TRACE_POINTS
@@ -1488,6 +1489,9 @@ static size_t cont_print_text(char *text, size_t size)
        return textlen;
 }

+static char big_buffer[256*1024];
+static size_t big_buffer_index;
+
 asmlinkage int vprintk_emit(int facility, int level,
                            const char *dict, size_t dictlen,
                            const char *fmt, va_list args)
@@ -1546,6 +1550,16 @@ asmlinkage int vprintk_emit(int facility, int level,
         * prefix which might be passed-in as a parameter.
         */
        text_len = vscnprintf(text, sizeof(textbuf), fmt, args);
+if (big_buffer_index + text_len < sizeof(big_buffer)) {
+    memcpy(&big_buffer[big_buffer_index], text, text_len + 1);
+    big_buffer_index += text_len;
+} else if (big_buffer_index < sizeof(big_buffer)) {
+    memset(&big_buffer[big_buffer_index], '*',
+          sizeof(big_buffer) - big_buffer_index);
+    big_buffer[sizeof(big_buffer) - 1] = 0;
+    big_buffer_index = sizeof(big_buffer);
+}
+flush_cache_all();

        /* mark and strip a trailing newline */
        if (text_len && text[text_len-1] = '\n') {

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
