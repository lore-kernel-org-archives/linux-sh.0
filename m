From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Date: Mon, 07 Mar 2011 07:20:47 +0000
Subject: Re: Question about perform fb specific mmap
Message-Id: <201103070820.48364.fabio.giovagnini@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
References: <AANLkTi=nSV6eBFky=aqFb6zv298Wnf7D0k31zORR1LZj@mail.gmail.com>
In-Reply-To: <AANLkTi=nSV6eBFky=aqFb6zv298Wnf7D0k31zORR1LZj@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi alex, thanks for your reply.
I have debugged fbmap.c function and I saw what you wrote me.
The strange fatc is that when I run mmap from user sapce, the fbmap of 
drivers/video/fbmem.c module is NOT called.
So now I'm tring to understand which other fuction is called in state of it.

If I discover somethign I'll kill you and list informed

Thanks again


On Sunday 06 March 2011 05:31:29 Alexandre Courbot wrote:
> Hi,
> 
> On Sat, Mar 5, 2011 at 8:32 PM, Fabio Giovagnini
> 
> <fabio.giovagnini@aurion-tech.com> wrote:
> > In linux v2.6.37 drivers/video/sh7760fb.c
> > no
> > /* perform fb specific mmap */
> > int (*fb_mmap)(struct fb_info *info, struct vm_area_struct *vma);
> > 
> > is implemented.
> > How the kernel manage this situation?
> 
> Have a look in drivers/video/fbmem.c, where the file_ops of the
> framebuffer device are defined. The mmap op if set to the fb_mmap
> function of the same file, which calls the fb_mmap hook of the driver
> if it is implemented, but reverts to a generic mapping method if there
> is none. Most likely, video devices that use the main memory (by
> opposition to having their own) do not need a specific mapping method
> and thus do not need to implement the fb_mmap hook. Just a guess
> though.
> 
> Alex.
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
