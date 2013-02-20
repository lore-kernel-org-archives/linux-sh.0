From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 20 Feb 2013 12:05:15 +0000
Subject: Re: [PATCH 0/3] serial/shmobile: Add OF support to SCI
Message-Id: <20130220120514.GB3833@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1361298586-30357-1-git-send-email-hechtb+renesas@gmail.com>
In-Reply-To: <1361298586-30357-1-git-send-email-hechtb+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Feb 19, 2013 at 12:29:43PM -0600, Bastian Hecht wrote:
> We add support to probe shmobile SCI devices using device tree.
> 
> Here we face the much discussed issue of device tree bindings and driver data
> configs. I followed the idea of grouping SoCs into similar hardware blocks.
> 
> The naming is:
> renesas,shmobile-sci-hwb-1	for sh7372, sh73a0, r8a7740 and
> renesas,shmobile-sci-hwb-2	for r8a7779
> 
> I looked up the configuration of the prementioned SoCs and came to the
> conclusion that
> +       .flags          = ...
> +       .scscr          = ...
> +       .scbrr_algo_id  = ...
> 
> are all properties that are SoC dependent and that they currently completely
> describe the SoC-related configuration. This is however based on estimation
> as the struct plat_sci_port contains more fields that are not used currently
> in any board code but might be needed in the future. I don't know that.
> 
I think you can probably safely ignore the init_pins and the gpios for
now, as this was more about preserving legacy behaviour and bolting on
crude API utilization when we started to track pins through the GPIO API.
Now that everything is moving towards or supportable via pinctrl/pinconf,
there should be no need to ever have to deal with any of this on new
SoCs.

If you don't want to deal with overrun detection or RTS/CTS that should
be fine, but it should be noted that the binding only implements a
restricted subset of functionality, in that case.

> Further I'm unsure how to add the DMA descriptors to the bindings. I haven't
> found a driver that uses DMA except the flctl, that uses "dmas" and "dma-names",
> but I don't know if this is still the way to go.
> 
There are no users that presently depend on this, so you can probably get
away with adding this as an incremental change at a later state.
