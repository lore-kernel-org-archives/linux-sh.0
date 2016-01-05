From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 05 Jan 2016 09:46:17 +0000
Subject: Re: [PATCHv2 3/3] thermal: improve hot trip handling
Message-Id: <CAMuHMdXdyLgM11Em-Vt_Hxidx_T85iT21zk-AAshNxEpgw_5Hg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1450379609-7826-1-git-send-email-edubezval@gmail.com>
	<1450379609-7826-4-git-send-email-edubezval@gmail.com>
In-Reply-To: <1450379609-7826-4-git-send-email-edubezval@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Rui Zhang <rui.zhang@intel.com>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

Hi Eduardo,

On Thu, Dec 17, 2015 at 8:13 PM, Eduardo Valentin <edubezval@gmail.com> wrote:
> The idea is to add the choice to be notified only when temperature
> crosses trip points. The trip points affected are the non-passive
> trip points.
>
> It will check last temperature and current temperature against
> the trip point temperature and its hysteresis.
> In case the check shows temperature has changed enought indicating
> a trip point crossing, a uevent will be sent to userspace.
>
> The uevent contains the thermal zone type, the current temperature,
> the last temperature and the trip point in which the current temperature
> now resides.
>
> The behavior of ops->notify() callback remains the same.
>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
> ---
> V1->V2: none
> ---
>  drivers/thermal/thermal_core.c | 52 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index a229c84..e0f1f4e 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -423,6 +423,56 @@ static void handle_non_critical_trips(struct thermal_zone_device *tz,
>                        def_governor->throttle(tz, trip);
>  }
>
> +static void thermal_tripped_notify(struct thermal_zone_device *tz,
> +                                  int trip, enum thermal_trip_type trip_type,
> +                                  int trip_temp)
> +{
> +       char tuv_name[THERMAL_NAME_LENGTH + 15], tuv_temp[25],
> +               tuv_ltemp[25], tuv_trip[25], tuv_type[25];
> +       char *msg[6] = { tuv_name, tuv_temp, tuv_ltemp, tuv_trip, tuv_type,
> +                       NULL };
> +       int upper_trip_hyst, upper_trip_temp, trip_hyst = 0;
> +       int ret = 0;
> +
> +       snprintf(tuv_name, sizeof(tuv_name), "THERMAL_ZONE=%s", tz->type);
> +       snprintf(tuv_temp, sizeof(tuv_temp), "TEMP=%d", tz->temperature);
> +       snprintf(tuv_ltemp, sizeof(tuv_ltemp), "LAST_TEMP=%d",
> +                tz->last_temperature);
> +       snprintf(tuv_trip, sizeof(tuv_trip), "TRIP=%d", trip);
> +       snprintf(tuv_type, sizeof(tuv_type), "TRIP_TYPE=%d", trip_type);
> +
> +       mutex_lock(&tz->lock);
> +
> +       /* crossing up */
> +       if (tz->last_temperature < trip_temp && trip_temp < tz->temperature)
> +               kobject_uevent_env(&tz->device.kobj, KOBJ_CHANGE, msg);
> +
> +       if (tz->ops->get_trip_hyst)
> +               tz->ops->get_trip_hyst(tz, trip, &trip_hyst);
> +
> +       /* crossing down, check for hyst */
> +       trip_temp -= trip_hyst;
> +       if (tz->last_temperature > trip_temp && trip_temp > tz->temperature) {
> +               snprintf(tuv_trip, sizeof(tuv_trip), "TRIP=%d", trip - 1);
> +               kobject_uevent_env(&tz->device.kobj, KOBJ_CHANGE, msg);
> +       }
> +
> +       ret = tz->ops->get_trip_temp(tz, trip + 1, &upper_trip_temp);

"trip + 1" may be equal to thermal_zone_device.trips and thus out-of-range,
in which case rcar_thermal_get_trip_temp() will print an error message:

    rcar_thermal e61f0000.thermal: rcar driver trip error

Is the "+ 1" (also below) intentional?
If yes, I think the related error messages in rcar_thermal.c should be reduced
to debug messages.

> +       if (ret)
> +               goto unlock;
> +
> +       if (tz->ops->get_trip_hyst)
> +               tz->ops->get_trip_hyst(tz, trip + 1, &upper_trip_hyst);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
