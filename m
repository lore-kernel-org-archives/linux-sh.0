From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 18 Sep 2012 07:12:08 +0000
Subject: Re: GPIO request failure with PCF pinmux
Message-Id: <20120918071208.GL13568@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <6045802.ynsOILKLIK@avalon>
In-Reply-To: <6045802.ynsOILKLIK@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Sep 14, 2012 at 10:11:00PM +0200, Laurent Pinchart wrote:
> Hi Paul,
> 
> I ran into an issue with GPIO and pinmuxing in the TPU PWM driver.
> 
> The driver needs to switch the PWM pin between GPIO and function at runtime. 
> To do so, I use the PWM pin GPIO (GPIO_PORT202) and the associated function 
> GPIO (GPIO_FN_TPU0TO2_PORT202).
> 
> The driver configures the pin as a GPIO output when loaded with
> 
> 	gpio_request_one(GPIO_PORT202, GPIOF_INIT_LOW);
> 
> This results in a call to sh_pfc_gpio_request_enable() followed by a call to 
> sh_pfc_reconfig_pin() for GPIO 202. The later changes the pinmux type from 
> PINMUX_TYPE_GPIO (2) to PINMUX_TYPE_OUTPUT (3).
> 
> I then call gpio_free(GPIO_PORT202) and gpio_request(GPIO_FN_TPU0TO2_PORT202) 
> to switch from GPIO to function. The former calls sh_pfc_gpio_disable_free:() 
> on GPIO 202.
> 
> When I later call gpio_free(GPIO_FN_TPU0TO2_PORT202) and 
> gpio_request_one(GPIO_PORT202, GPIOF_INIT_LOW), the call to 
> sh_pfc_gpio_request_enable() fails with
> 
> pinctrl-sh_pfc pinctrl: Unsupported mux type (3), bailing...
> pinctrl-sh_pfc pinctrl-sh_pfc: request() failed for pin 202
> pinctrl-sh_pfc pinctrl-sh_pfc: pin-202 (pinctrl-sh_pfc) status -524
> 
> You're more familiar with pinmux than I am. Am I doing something wrong, or is 
> there a bug in the PFC pinmux implementation ?
> 
That's a bug, the pin has been reconfigured to a different mux type which
we should handle. At first glance, simply handling the input/output types
ought to work ok, but we may need more work than that. How does it go
with this?

---

diff --git a/drivers/sh/pfc/pinctrl.c b/drivers/sh/pfc/pinctrl.c
index 2804eaa..c0857d5 100644
--- a/drivers/sh/pfc/pinctrl.c
+++ b/drivers/sh/pfc/pinctrl.c
@@ -208,6 +208,8 @@ static int sh_pfc_gpio_request_enable(struct pinctrl_dev *pctldev,
 
 		break;
 	case PINMUX_TYPE_GPIO:
+	case PINMUX_TYPE_INPUT:
+	case PINMUX_TYPE_OUTPUT:
 		break;
 	default:
 		pr_err("Unsupported mux type (%d), bailing...\n", pinmux_type);
