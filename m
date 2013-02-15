From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 15 Feb 2013 01:46:09 +0000
Subject: Re: [PATCH] input: st1232: Add IRQF_NO_SUSPEND flag
Message-Id: <CANqRtoQzhfxaHJp+vj=GnAaR4NyD9U1F1B7EnRckdLqvJE=XEw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1360863132-11227-1-git-send-email-hechtb+renesas@gmail.com>
In-Reply-To: <1360863132-11227-1-git-send-email-hechtb+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bastian Hecht <hechtb@gmail.com>
Cc: linux-input@vger.kernel.org, linux-sh@vger.kernel.org, Tony SIM <chinyeow.sim.xt@renesas.com>, Bastian Hecht <hechtb+renesas@gmail.com>

Hi Bastian,

On Fri, Feb 15, 2013 at 2:32 AM, Bastian Hecht <hechtb@gmail.com> wrote:
> When registering the interrupt handler we add the IRQF_NO_SUSPEND flag
> to save the IRQ line from being disabled during suspension. This way we
> keep the ability to use the device as a wakeup source.
>
> Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
> ---
>  drivers/input/touchscreen/st1232.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/input/touchscreen/st1232.c b/drivers/input/touchscreen/st1232.c
> index d9d05e2..4f37199 100644
> --- a/drivers/input/touchscreen/st1232.c
> +++ b/drivers/input/touchscreen/st1232.c
> @@ -180,7 +180,7 @@ static int st1232_ts_probe(struct i2c_client *client,
>         input_set_abs_params(input_dev, ABS_MT_POSITION_Y, MIN_Y, MAX_Y, 0, 0);
>
>         error = request_threaded_irq(client->irq, NULL, st1232_ts_irq_handler,
> -                                    IRQF_ONESHOT, client->name, ts);
> +                       IRQF_ONESHOT | IRQF_NO_SUSPEND, client->name, ts);

Are you sure this is the correct way to handle this? Which platform
have you tested this on? How about other boards?

Usually wake up handling is dealt with separately from interrupts.
Looks like something is missing in your interrupt controller code.

Thanks,

/ magnus
