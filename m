From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 19 Jun 2012 06:41:05 +0000
Subject: Re: [PATCH 2/6] misc: Add Renesas Mobile TPU PWM driver
Message-Id: <CANqRtoReT2F9yhcJPG4euA0TN5dkaFxZL8-RGbWPN5t6JY_Ggw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1339773427-29508-3-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1339773427-29508-3-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Laurent,

On Sat, Jun 16, 2012 at 12:17 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> The Timer Pulse Unit (TPU is a 4-channels 16-bit timer used to generate
> waveforms. This driver exposes PWM functions through the PWM API for
> other drivers to use.
>
> The code is loosely based on the leds-renesas-tpu driver by Magnus Damm
> and the TPU PWM driver shipped in the Armadillo EVA 800 kernel sources.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---

I think this looks good in general, but I have one concern:

> +struct pwm_device {
> + =A0 =A0 =A0 struct list_head list;
> + =A0 =A0 =A0 enum tpu_pin_state pin_state;
> + =A0 =A0 =A0 bool pwm_enabled; =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Whether th=
e PWM output is enabled */
> + =A0 =A0 =A0 bool timer_on; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Whethe=
r the timer is running */
> + =A0 =A0 =A0 bool in_use;
> +
> + =A0 =A0 =A0 struct rmob_tpu_pwm_channel_data *pdata;
> + =A0 =A0 =A0 struct tpu_device *tpu;
> + =A0 =A0 =A0 unsigned int id; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Global P=
WM ID */

So according to the comment above, this is a global identifier.

> +struct pwm_device *pwm_request(int pwm_id, const char *label)
> +{
> + =A0 =A0 =A0 struct pwm_device *pwm;
> +
> + =A0 =A0 =A0 mutex_lock(&pwm_lock);
> + =A0 =A0 =A0 list_for_each_entry(pwm, &pwm_list, list) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pwm->id !=3D pwm_id)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;

Here we check for it...

> +static int __devinit tpu_probe(struct platform_device *pdev)
> +{
...
> + =A0 =A0 =A0 for (i =3D 0; i < ARRAY_SIZE(tpu->pwms); ++i) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct pwm_device *pwm =3D &tpu->pwms[i];
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!pdata->channels[i].pin_gpio &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !pdata->channels[i].pin_gpio_fn)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwm->tpu =3D tpu;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwm->id =3D tpu->pdev->id * RMOB_TPU_CHANNE=
L_MAX + i;

And here we assign it based on RMOB_TPU_CHANNEL_MAX.

This snippet is from the kota2 board code:

+static struct led_pwm tpu_pwm_leds[] =3D {
+       {
+               .name           =3D "V2513",
+               .pwm_id         =3D 6,
+               .max_brightness =3D 1000,
+       }, {
+               .name           =3D "V2515",
+               .pwm_id         =3D 9,
+               .max_brightness =3D 1000,
+       }, {
+               .name           =3D "KEYLED",
+               .pwm_id         =3D 12,
+               .max_brightness =3D 1000,
+       }, {
+               .name           =3D "V2514",
+               .pwm_id         =3D 17,
+               .max_brightness =3D 1000,
+       },
+};

So the above "pwm_id" values in the board code depend on
RMOB_TPU_CHANNEL_MAX being set to 4. In the future I believe we want
these described via DT.

Which brings me to the my question: How can we expand the number of
channels but not changing the board code? I predict that the number of
channels will not remain at 4.

Also, if this is supposed to be a global identifier, can't it clash
with other ids provided by other drivers?

My simple solution to this problem would be to allow the user to set
the id via platform data, but I'm not sure if that's what we want
together with DT.

Also, before we add DT we surely want to make use of PINCTRL for pin
function support, but we need to rework our SoC PFC code first.

Cheers,

/ magnus
