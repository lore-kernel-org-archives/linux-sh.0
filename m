From: "Magnus Damm" <magnus.damm@gmail.com>
Date: Wed, 10 Dec 2008 08:19:37 +0000
Subject: Re: [PATCH 02/10] clockevent: let set_mode() setup delta information
Message-Id: <aec7e5c30812100019q3069627cr1a49d2abf54bd19e@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20081201103242.26620.86716.sendpatchset@rx1.opensource.se>
In-Reply-To: <20081201103242.26620.86716.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi guys,

Any comments on this patch? It allow us to use the frequency from the
clock framework.
Please let me know what you think. Thanks for your help.

Cheers,

/ magnus

On Mon, Dec 1, 2008 at 7:32 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> From: Magnus Damm <damm@igel.co.jp>
>
> Allow the set_mode() clockevent callback to decide and fill in delta
> details such as shift, mult, max_delta_ns and min_delta_ns.
>
> With this change the clockevent can be registered without delta details
> which allows us to keep the parent clock disabled until the clockevent
> gets setup using set_mode().
>
> Letting set_mode() fill in or update delta details allows us to save
> power by disabling the parent clock while the clockevent is unused.
> This may however make the parent clock rate change, so next time the
> clockevent gets enabled we need let set_mode() to update the detla
> details accordingly. Doing it at registration time is not enough.
>
> Furthermore, the delta details seem unused in the case of periodic-only
> clockevent drivers, so this change also allows registration of such
> drivers without the delta details filled in.
>
> Signed-off-by: Magnus Damm <damm@igel.co.jp>
> ---
>
>  kernel/time/clockevents.c |   20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
>
> --- 0001/kernel/time/clockevents.c
> +++ work/kernel/time/clockevents.c      2008-11-28 15:51:31.000000000 +0900
> @@ -68,6 +68,17 @@ void clockevents_set_mode(struct clock_e
>        if (dev->mode != mode) {
>                dev->set_mode(mode, dev);
>                dev->mode = mode;
> +
> +               /*
> +                * A nsec2cyc multiplicator of 0 is invalid and we'd crash
> +                * on it, so fix it up and emit a warning:
> +                */
> +               if (mode = CLOCK_EVT_MODE_ONESHOT) {
> +                       if (unlikely(!dev->mult)) {
> +                               dev->mult = 1;
> +                               WARN_ON(1);
> +                       }
> +               }
>        }
>  }
>
> @@ -166,15 +177,6 @@ static void clockevents_notify_released(
>  void clockevents_register_device(struct clock_event_device *dev)
>  {
>        BUG_ON(dev->mode != CLOCK_EVT_MODE_UNUSED);
> -       /*
> -        * A nsec2cyc multiplicator of 0 is invalid and we'd crash
> -        * on it, so fix it up and emit a warning:
> -        */
> -       if (unlikely(!dev->mult)) {
> -               dev->mult = 1;
> -               WARN_ON(1);
> -       }
> -
>        spin_lock(&clockevents_lock);
>
>        list_add(&dev->list, &clockevent_devices);
>
