From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Date: Sat, 05 Mar 2011 11:32:02 +0000
Subject: Question about  perform fb specific mmap
Message-Id: <201103051232.02755.fabio.giovagnini@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi All,
sorry if I write some dummy question but I'm tring to undersatnd better all 
the kernel structure.
In linux v2.6.37 drivers/video/sh7760fb.c
no 	
/* perform fb specific mmap */
int (*fb_mmap)(struct fb_info *info, struct vm_area_struct *vma);

is implemented.
How the kernel manage this situation?

I'm asking this, because I'm tring to write sh7203fb.c and when I execute my 
driver I can read.
fabioDebug: STBCR4 0x39
fabioDebug: sh7203fb_get_color_info - lddfr=0x2d;LDDFR_COLOR_MASK=0x7f
fabioDebug: sh7203fb_get_color_info - bpp
fabioDebug: sh7203fb_get_color_info - Exit
fabioDebug: sh7203fb_check_var
fabioDebug: sh7203fb_get_color_info - lddfr=0x2d;LDDFR_COLOR_MASK=0x7f
fabioDebug: sh7203fb_get_color_info - bpp
fabioDebug: sh7203fb_get_color_info - Exit
fabioDebug: sh7203fb_alloc_mem - 
info->screen_base:25800
info->screen_size:e100000
info->fix.smem_start25800
info->fix.smem_lenc1691f8
sh7203-lcdc: memory at phys 0x0e100000-0x0e1257ff, size 150 KiB
fabioDebug: sh7203fb_set_par
fabioDebug: sh7203fb_get_color_info - lddfr=0x2d;LDDFR_COLOR_MASK=0x7f
fabioDebug: sh7203fb_get_color_info - bpp
fabioDebug: sh7203fb_get_color_info - gray=0
fabioDebug: sh7203fb_get_color_info - Exit
fabioDebug: sh7203fb_blank
fabioDebug: tring to stop the LCD
fabioDebug: wait_for_lps
fabioDebug: sh7203fb_check_var
fabioDebug: sh7203fb_get_color_info - lddfr=0x2d;LDDFR_COLOR_MASK=0x7f
fabioDebug: sh7203fb_get_color_info - bpp
fabioDebug: sh7203fb_get_color_info - Exit
fabioDebug: sh7203fb_blank
fabioDebug: tring to start the LCD
fabioDebug: wait_for_lps
hdcn  :    320 htcn  :    520
hsynw :     96 hsynp :    344
vdln  :    240 vtln  :    272
vsynw :      1 vsynp :    241
clksrc:      1 clkdiv:      2
ldpmmr: 0x0000 ldpspr: 0xffff
ldmtr : 0xc42b lddfr : 0x002d
ldlaor: 640
ldsaru: 0x0e100000 ldsarl: 0x00000000
SuperH SCI(F) driver initialized

0x0e100000 is the base address.

what I read in the user space is:
The framebuffer device was opened successfully.
320x240, 16bpp
The framebuffer device was mapped to memory successfully.
The framebuffer base address:0xe9c0000.
fbtest used greatest stack depth: 6396 bytes left

How could I solve

On Friday 04 March 2011 07:03:26 Paul Mundt wrote:
> On Wed, Mar 02, 2011 at 06:05:21PM +0900, Kuninori Morimoto wrote:
> > mackerel WVGA LCDC panel expect 33.3MHz for dot-clock,
> > but current dot-clock was 50.0MHz.
> > This patch modify clock divider value.
> 
> On Wed, Mar 02, 2011 at 06:05:44PM +0900, Kuninori Morimoto wrote:
> > ap4evb WVGA LCDC panel expect 33.3MHz for dot-clock,
> > but current dot-clock was 50.0MHz.
> > This patch modify clock divider value.
> 
> Both applied for .38, thanks.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Ing. Fabio Giovagnini

Aurion s.r.l.
P.I e C.F.
00885711200
skype: aurion.giovagnini
Tel. +39.051.594.78.24
Fax. +39.051.082.14.49
Cell. +39.335.83.50.919
www.aurion-tech.com
