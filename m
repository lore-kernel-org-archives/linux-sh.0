From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 24 Jul 2012 13:59:02 +0000
Subject: Re: [PATCH 2/6] misc: Add Renesas Mobile TPU PWM driver
Message-Id: <5128838.4ZV0ccWJnd@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1339773427-29508-3-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1339773427-29508-3-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

On Tuesday 19 June 2012 15:41:05 Magnus Damm wrote:
> On Sat, Jun 16, 2012 at 12:17 AM, Laurent Pinchart wrote:
> > The Timer Pulse Unit (TPU is a 4-channels 16-bit timer used to generate
> > waveforms. This driver exposes PWM functions through the PWM API for
> > other drivers to use.
> > 
> > The code is loosely based on the leds-renesas-tpu driver by Magnus Damm
> > and the TPU PWM driver shipped in the Armadillo EVA 800 kernel sources.
> > 
> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > ---
> 
> I think this looks good in general, but I have one concern:
> > +struct pwm_device {
> > +       struct list_head list;
> > +       enum tpu_pin_state pin_state;
> > +       bool pwm_enabled;               /* Whether the PWM output is
> > enabled */ +       bool timer_on;                  /* Whether the timer
> > is running */ +       bool in_use;
> > +
> > +       struct rmob_tpu_pwm_channel_data *pdata;
> > +       struct tpu_device *tpu;
> > +       unsigned int id;                /* Global PWM ID */
> 
> So according to the comment above, this is a global identifier.
> 
> > +struct pwm_device *pwm_request(int pwm_id, const char *label)
> > +{
> > +       struct pwm_device *pwm;
> > +
> > +       mutex_lock(&pwm_lock);
> > +       list_for_each_entry(pwm, &pwm_list, list) {
> > +               if (pwm->id != pwm_id)
> > +                       continue;
> 
> Here we check for it...
> 
> > +static int __devinit tpu_probe(struct platform_device *pdev)
> > +{
> 
> ...
> 
> > +       for (i = 0; i < ARRAY_SIZE(tpu->pwms); ++i) {
> > +               struct pwm_device *pwm = &tpu->pwms[i];
> > +
> > +               if (!pdata->channels[i].pin_gpio &&
> > +                   !pdata->channels[i].pin_gpio_fn)
> > +                       continue;
> > +
> > +               pwm->tpu = tpu;
> > +               pwm->id = tpu->pdev->id * RMOB_TPU_CHANNEL_MAX + i;
> 
> And here we assign it based on RMOB_TPU_CHANNEL_MAX.
> 
> This snippet is from the kota2 board code:
> 
> +static struct led_pwm tpu_pwm_leds[] = {
> +       {
> +               .name           = "V2513",
> +               .pwm_id         = 6,
> +               .max_brightness = 1000,
> +       }, {
> +               .name           = "V2515",
> +               .pwm_id         = 9,
> +               .max_brightness = 1000,
> +       }, {
> +               .name           = "KEYLED",
> +               .pwm_id         = 12,
> +               .max_brightness = 1000,
> +       }, {
> +               .name           = "V2514",
> +               .pwm_id         = 17,
> +               .max_brightness = 1000,
> +       },
> +};
> 
> So the above "pwm_id" values in the board code depend on
> RMOB_TPU_CHANNEL_MAX being set to 4. In the future I believe we want
> these described via DT.
> 
> Which brings me to the my question: How can we expand the number of channels
> but not changing the board code? I predict that the number of channels will
> not remain at 4.

What about using a macro in platform code that would take the PWM device 
number and the PWM channel number ? The macro will essentially compute

dev_id * RMOB_TPU_CHANNEL_MAX + channel

If we later want to increase RMOB_TPU_CHANNEL_MAX no change to drivers or 
board code will be needed.

I'll resubmit the patch set with this change.

> Also, if this is supposed to be a global identifier, can't it clash with
> other ids provided by other drivers?

In theory it could, but in practice only one driver can expose the PWM API. We 
need a PWM framework/subsystem that would allow registering multiple PWM 
devices, but that's outside the scope of this patch set.

> My simple solution to this problem would be to allow the user to set the id
> via platform data, but I'm not sure if that's what we want together with DT.

DT bindings for led_pwm should reference the PWM DT node and specify the 
channel number.

> Also, before we add DT we surely want to make use of PINCTRL for pin
> function support, but we need to rework our SoC PFC code first.

I'll be glad to review patches ;-)

-- 
Regards,

Laurent Pinchart

