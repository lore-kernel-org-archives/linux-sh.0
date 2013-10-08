From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 08 Oct 2013 11:19:04 +0000
Subject: Re: [PATCH/RFC v4] ARM: shmobile: armadillo800eva-reference: add SDHI and MMCIF interfaces
Message-Id: <CACRpkdac_Efc7Vh0_m11zWuB0pgQzVnvy2kBjhn5KGhwwv1oDw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1309231651230.11505@axis700.grange>
	<2318676.bdc47MCX2p@avalon>
	<CACRpkdbtQy16waQnp2Os0bx5f0AGigHJysMcJnga+FsMEN27iA@mail.gmail.com>
	<138071238.VjAY8SX7B8@avalon>
In-Reply-To: <138071238.VjAY8SX7B8@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@linaro.org>, Simon Horman <horms@verge.net.au>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>

On Mon, Sep 30, 2013 at 1:10 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Linus,
>
> [Updated the devicetree mailing list e-mail address]
>
> On Monday 30 September 2013 01:20:46 Linus Walleij wrote:
>> On Sun, Sep 29, 2013 at 8:49 AM, Laurent Pinchart wrote:
>> > On Friday 27 September 2013 16:08:31 Linus Walleij wrote:
>> >> Can't you just locate the node using of_find_node_by_path()
>> >> or whatever and then use this:
>> >> int of_update_property(struct device_node *np, struct property *newprop)?
>> >
>> > Where can I do that ? I need the PFC/GPIO devices to have been probed, so
>> > board init isn't an option, but I also need the device to be enabled not
>> > to have been probed yet.
>> >
>> > One option would be to use a bus notifier to find out when the PFC/GPIO
>> > devices are available, and extend of_update_property() with a notification
>> > mechanism (either generic, or specific to the enabled propery) to detect
>> > when a device gets enabled and probe it.
>>
>> Argh that sounds awfully complicated...
>>
>> I would consider doing this right inside the PCF/GPIO driver right at the
>> end of its probe function. As it is related to pins anyway... or is that too
>> ugly?
>
> As a reminder, we need to decide whether to register an SDHI (SD controller)
> device or a WiFi module device, and thus configure pinmuxing appropriately,
> based on the state of a GPIO connected to a user-accessible switch. This
> behaviour is board-specific, not SoC-specific. That's why I believe the code
> should be in board code.

Hm, I might have misunderstood this earlier, so if the board code is
going to register *either* SDHI *or* WIFI, both as some kind of
struct device then as you say:

> The board has two connectors (MMC/SD 1
> and wifi module) that are not usable concurrently. The user can select which
> connector to use through a hardware switch that existing board code reads at
> init time (...)

So depending on what you read there you're going to register a
struct device named mmc0 or wifi0 or something, then you just register
the pin control tables for both cases and the apropriate default state
will be selected by the device core right before the device driver
gets probed. (grep for pinctrl_bind_pins). It is perfectly fine to have
unused pin states in the table.

Then the problem is unrelated to pin control and more about how
to register these devices, nothing to do with pin control.

Such as if they should both be marked as "disabled" in the DT and
activated by the kernel, or registered by adding a platform device
or something...

But I guess I got it wrong?

Yours,
Linus Walleij
