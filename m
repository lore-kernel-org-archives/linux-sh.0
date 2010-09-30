From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 30 Sep 2010 01:06:51 +0000
Subject: Re: [PATCH] sh: boot kernel with SR.BL set
Message-Id: <20100930010651.GB18073@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20100924090538.13826.99190.sendpatchset@t400s>
In-Reply-To: <20100924090538.13826.99190.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Sep 24, 2010 at 06:05:38PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Update the SH kernel to keep SR.BL set until the VBR
> register has been initialized. Useful to allow boot
> of the kernel even though exceptions are pending.
> 
> Without this patch there is a window of time when
> exceptions such as NMI are enabled but no exception
> handlers are installed.
> 
> This patch modifies both the zImage loader and the
> actual kernel to boot with BL=1, but the zImage
> loader is modfied in such a way that the init_sr
> value is unchanged to not break the zImage loader
> provided by kexec.
> 
> Tested on sh7724 Ecovec and on the SH4AL-DSP core
> included in sh7372.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

I've applied this, but in the future make sure you update all of the CPUs
when making changes to the boot path. Presently this is introducing a
divergence for all of the nommu parts which we do not want.
