From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Date: Wed, 03 Dec 2014 13:03:32 +0000
Subject: Re: [PATCH v2 7/7] pinctrl: qcom-spmi-gpio: Migrate to pinconf-generic
Message-Id: <1417611812.30615.28.camel@mm-sol.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1417137993-8337-1-git-send-email-soren.brinkmann@xilinx.com>
 <1417137993-8337-8-git-send-email-soren.brinkmann@xilinx.com>
In-Reply-To: <1417137993-8337-8-git-send-email-soren.brinkmann@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org


On Thu, 2014-11-27 at 17:26 -0800, Soren Brinkmann wrote:
> Instead of the driver caring about implementation details like device
> tree, just provide information about driver specific pinconf parameters
> to pinconf-generic which takes care of parsing the DT.
> 
> Signed-off-by: Soren Brinkmann brinkmann@xilinx.com>
> ---
> This is compile tested only. So, it's likely that it needs more tweaking
> to make it actually work on HW. But it illustrates the potential
> benefits of the pinconf-generic changes in this series.
> ---
>  drivers/pinctrl/qcom/pinctrl-spmi-gpio.c | 125 +++----------------------------
>  1 file changed, 11 insertions(+), 114 deletions(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
> index b863b5080890..2db85e53ef73 100644
> --- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
> +++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
> @@ -131,14 +131,14 @@ struct pmic_gpio_state {
>         struct gpio_chip chip;
>  };
> 
> -struct pmic_gpio_bindings {
> -       const char*property;
> -       unsigned      param;
> +static const struct pinconf_generic_dt_params pmic_gpio_bindings[] = {
> +       {"qcom,pull-up-strength",PMIC_GPIO_CONF_PULL_UP,0},
> +       {"qcom,drive-strength",PMIC_GPIO_CONF_STRENGTH,0},
>  };
> 
> -static struct pmic_gpio_bindings pmic_gpio_bindings[] = {
> -       {"qcom,pull-up-strength",PMIC_GPIO_CONF_PULL_UP},
> -       {"qcom,drive-strength",PMIC_GPIO_CONF_STRENGTH},
> +static const struct pin_config_item pmic_conf_items[] = {
> +       PCONFDUMP(PMIC_GPIO_CONF_PULL_UP,  "pull-up-strength", NULL, true),

s/pull-up-strength/qcom,pull-up-strength/

> +       PCONFDUMP(PMIC_GPIO_CONF_STRENGTH, "drive-strength", NULL, true),
>  };
> 



I am not happy that we have to define the same think two times.

Regards,
Ivan
