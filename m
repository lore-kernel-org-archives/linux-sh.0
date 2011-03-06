From: Alexandre Courbot <alex@dcl.info.waseda.ac.jp>
Date: Sun, 06 Mar 2011 04:31:29 +0000
Subject: Re: Question about perform fb specific mmap
Message-Id: <AANLkTi=nSV6eBFky=aqFb6zv298Wnf7D0k31zORR1LZj@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

On Sat, Mar 5, 2011 at 8:32 PM, Fabio Giovagnini
<fabio.giovagnini@aurion-tech.com> wrote:
> In linux v2.6.37 drivers/video/sh7760fb.c
> no
> /* perform fb specific mmap */
> int (*fb_mmap)(struct fb_info *info, struct vm_area_struct *vma);
>
> is implemented.
> How the kernel manage this situation?

Have a look in drivers/video/fbmem.c, where the file_ops of the
framebuffer device are defined. The mmap op if set to the fb_mmap
function of the same file, which calls the fb_mmap hook of the driver
if it is implemented, but reverts to a generic mapping method if there
is none. Most likely, video devices that use the main memory (by
opposition to having their own) do not need a specific mapping method
and thus do not need to implement the fb_mmap hook. Just a guess
though.

Alex.
