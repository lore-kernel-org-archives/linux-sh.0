From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 24 Jun 2013 09:43:43 +0000
Subject: Re: [RFC] pinctrl: generic: Add DT bindings
Message-Id: <CACRpkdaXv=5PNt4EZPbcWzHYE4XAYmALqyV7v51QA+s63ZvFiQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1370988237-30593-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<51C22985.50106@wwwdotorg.org>
In-Reply-To: <51C22985.50106@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, James Hogan <james.hogan@imgtec.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

On Wed, Jun 19, 2013 at 11:58 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 06/11/2013 04:03 PM, Laurent Pinchart wrote:

>> +- tristate: A boolean, put the pin into high impedance state when set.

The other patch defines bias-high-impedance which is more likely
to be the string used.

Anyway:

> I don't think that a Boolean is appropriate here; it's really a tri-state:
>
> * Nothing is specified about the tristate value; don't touch that aspect
> of HW.
> * Turn tristate on.
> * Turn tristate off.

I was thinking more about using bias-disable; to explicitly turn that
off.

But maybe a specific disable option is needed, like for schmitt-trigger
(see below).

> This can be a meaningful distinction when relying on e.g. the bootloader
> having already set up the appropriate tristate value, or when
> dynamically switching between different pinctrl states and not wanting
> to affect tristate, or when piecing together multiple DT nodes that
> describe part of a state, where one node covers just muxing and the
> other just pin config (e.g. where the mux and pin config configuration
> registers in HW affect different overlapping groups).

OK point taken... although when we're dealing with generic pin config
the idea is not to cover everything but the majority of not-so-complicated
cases.

>> +- schmitt: An integer, enable or disable Schmitt trigger mode for the pins.
>> +  Valid values are
>> +    0: Schmitt trigger disabled (no hysteresis)
>> +    1: Schmitt trigger enabled
>
> A similar comment applies here.

The other patch adds:
input-schmitt-enable;
input-schmitt-disable;

So this is covered.

>> +- slew-rate: An integer controlling the pin slew rate. Values are device-
>> +  dependent.
>> +
>> +- drive-strength: An integer representing the drive strength of pins in mA.
>> +  Valid values are device-dependent.
>
> I'm still not convinced that requiring this to be in mA is a good idea.
> Different HW will use different units for documentation, or even specify
> no units at all, so it might not always be possible to represent this in
> terms of mA. Asking for the documentation to be re-written simply to
> support the DT binding just isn't going to happen.

We can add custom DT bindings for these. This is to cover those
where we know enough about it to actually use this generic binding.
If we don't really know what is happening we may as well call it
vendor,foo = <?>;

Yours,
Linus Walleij
