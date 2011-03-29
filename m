From: Damian <dhobsong@igel.co.jp>
Date: Tue, 29 Mar 2011 04:48:48 +0000
Subject: Re: [PATCH] fbdev: sh_mobile_lcdcfb: add blanking support
Message-Id: <4D9164B0.4030008@igel.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1298450190-3803-1-git-send-email-gnurou@gmail.com>
In-Reply-To: <1298450190-3803-1-git-send-email-gnurou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello Magnus and Alexandre,
On 2011/03/21 16:40, Magnus Damm wrote:
> On Wed, Feb 23, 2011 at 5:36 PM, Alexandre Courbot<gnurou@gmail.com>  wrote:
>> Add a blanking callback to the LCDC driver in order to support both
>> FBIOBLANK and TIOCLINUX blanking ioctls. LCDC clocks are also released
>> if the requested blanking level is superior to FB_BLANK_NORMAL, to allow
>> runtime PM to disable the clocks if possible.
>>
>> Signed-off-by: Alexandre Courbot<gnurou@gmail.com>
>
> I just tried this on the Mackerel board, seems fine to me.
>
> Acked-by: Magnus Damm<damm@opensource.se>
> --
 > +		struct fb_fillrect rect = {
 > +			.width = info->var.xres,
 > +			.height = info->var.yres,
 > +		};
 > +		sh_mobile_lcdc_fillrect(info, &rect);

I noticed that this patch only blanks the first screen of the buffer.
What about the rest of the buffer in a double or triple-buffer 
configuration (i.e. should .height = info->var.yres_virtual instead of 
info->var.yres)?

Thanks,
Damian
