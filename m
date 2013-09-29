From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sun, 29 Sep 2013 06:49:26 +0000
Subject: Re: [PATCH/RFC v4] ARM: shmobile: armadillo800eva-reference: add SDHI and MMCIF interfaces
Message-Id: <2318676.bdc47MCX2p@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1309231651230.11505@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1309231651230.11505@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Linus,

On Friday 27 September 2013 16:08:31 Linus Walleij wrote:
> On Fri, Sep 27, 2013 at 2:55 AM, Laurent Pinchart wrote:
> > Is there a way to patch the device tree in the board code init function to
> > turn "disabled" into "okay" based on the state of a GPIO ?
> 
> Can't you just locate the node using of_find_node_by_path()
> or whatever and then use this:
> int of_update_property(struct device_node *np, struct property *newprop)?

Where can I do that ? I need the PFC/GPIO devices to have been probed, so 
board init isn't an option, but I also need the device to be enabled not to 
have been probed yet.

One option would be to use a bus notifier to find out when the PFC/GPIO 
devices are available, and extend of_update_property() with a notification 
mechanism (either generic, or specific to the enabled propery) to detect when 
a device gets enabled and probe it.

Before implementing that, I'd like to know if this approach has a chance to be 
accepted.

> It's not like I'm a master of DT but... I'd very much like to know as well,
> because it'd be very useful :-)

-- 
Regards,

Laurent Pinchart

