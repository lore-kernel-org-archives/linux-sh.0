From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 14 Sep 2009 05:10:08 +0000
Subject: Re: [PATCH] sh: remove set_bus_parent() from clock-sh7709.c file
Message-Id: <20090914051008.GE15078@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20090914030158.GA22263@rafazurita.homelinux.net>
In-Reply-To: <20090914030158.GA22263@rafazurita.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Sep 14, 2009 at 12:01:58AM -0300, Rafael Ignacio Zurita wrote:
> It prevents the change of the parent of sh7709_cpu_clk and
> sh7709_module_clk (which does not work with that
> set_bus_parent() in the current scheme).
> 
> Signed-off-by: Rafael Ignacio Zurita <rizurita@yahoo.com>

I tidied up the changelog and pushed it out, thanks.
