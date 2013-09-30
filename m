From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 30 Sep 2013 11:10:34 +0000
Subject: Re: [PATCH/RFC v4] ARM: shmobile: armadillo800eva-reference: add SDHI and MMCIF interfaces
Message-Id: <138071238.VjAY8SX7B8@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1309231651230.11505@axis700.grange> <2318676.bdc47MCX2p@avalon> <CACRpkdbtQy16waQnp2Os0bx5f0AGigHJysMcJnga+FsMEN27iA@mail.gmail.com>
In-Reply-To: <CACRpkdbtQy16waQnp2Os0bx5f0AGigHJysMcJnga+FsMEN27iA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@linaro.org>, Simon Horman <horms@verge.net.au>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

Hi Linus,

[Updated the devicetree mailing list e-mail address]

On Monday 30 September 2013 01:20:46 Linus Walleij wrote:
> On Sun, Sep 29, 2013 at 8:49 AM, Laurent Pinchart wrote:
> > On Friday 27 September 2013 16:08:31 Linus Walleij wrote:
> >> Can't you just locate the node using of_find_node_by_path()
> >> or whatever and then use this:
> >> int of_update_property(struct device_node *np, struct property *newprop)?
> > 
> > Where can I do that ? I need the PFC/GPIO devices to have been probed, so
> > board init isn't an option, but I also need the device to be enabled not
> > to have been probed yet.
> > 
> > One option would be to use a bus notifier to find out when the PFC/GPIO
> > devices are available, and extend of_update_property() with a notification
> > mechanism (either generic, or specific to the enabled propery) to detect
> > when a device gets enabled and probe it.
> 
> Argh that sounds awfully complicated...
> 
> I would consider doing this right inside the PCF/GPIO driver right at the
> end of its probe function. As it is related to pins anyway... or is that too
> ugly?

As a reminder, we need to decide whether to register an SDHI (SD controller) 
device or a WiFi module device, and thus configure pinmuxing appropriately, 
based on the state of a GPIO connected to a user-accessible switch. This 
behaviour is board-specific, not SoC-specific. That's why I believe the code 
should be in board code.

-- 
Regards,

Laurent Pinchart

