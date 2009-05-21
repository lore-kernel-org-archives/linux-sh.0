From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 21 May 2009 17:45:21 +0000
Subject: Re: [PATCH] sh: ap325 camera without i2c driver fix
Message-Id: <20090521174521.GA2552@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20090520143006.8314.55548.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090520143006.8314.55548.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, May 20, 2009 at 11:30:06PM +0900, Magnus Damm wrote:
> This patch fixes the ap325rxa ncm03j camera code to handle
> the case where no i2c driver is present. Without this fix
> i2c_transfer() may be passed NULL as adapter which results
> in a crash.
> 
> Triggered when i2c-sh_mobile.c failed to probe() due to
> missing MSTP clocks.

On Wed, May 20, 2009 at 11:34:43PM +0900, Magnus Damm wrote:
> This patch fixes the LCDC driver to avoid calling the
> function sh_mobile_lcdc_start_stop(priv, 0) unless the
> same function has been called before to start the LCDC
> hardware.
> 
> Triggered when sh_mobile_lcdcfb.c failed to probe() due to
> missing MSTP clocks.

I was going to apply these, but as you provided no information as to what
branch these should be applied to, I didn't bother. Is this a problem
only in sh/clkfwk? Is this a problem with HEAD? Does it need to go in
2.6.30? If you are going to post a bunch of seemingly unrelated patches
in one go, it helps to know what exactly you want done with them.
