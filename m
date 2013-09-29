From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 29 Sep 2013 23:20:46 +0000
Subject: Re: [PATCH/RFC v4] ARM: shmobile: armadillo800eva-reference: add SDHI and MMCIF interfaces
Message-Id: <CACRpkdbtQy16waQnp2Os0bx5f0AGigHJysMcJnga+FsMEN27iA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1309231651230.11505@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1309231651230.11505@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Sep 29, 2013 at 8:49 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Friday 27 September 2013 16:08:31 Linus Walleij wrote:

>> Can't you just locate the node using of_find_node_by_path()
>> or whatever and then use this:
>> int of_update_property(struct device_node *np, struct property *newprop)?
>
> Where can I do that ? I need the PFC/GPIO devices to have been probed, so
> board init isn't an option, but I also need the device to be enabled not to
> have been probed yet.
>
> One option would be to use a bus notifier to find out when the PFC/GPIO
> devices are available, and extend of_update_property() with a notification
> mechanism (either generic, or specific to the enabled propery) to detect when
> a device gets enabled and probe it.

Argh that sounds awfully complicated...

I would consider doing this right inside the PCF/GPIO driver
right at the end of its probe function. As it is related to pins
anyway... or is that too ugly?

Yours,
Linus Walleij
