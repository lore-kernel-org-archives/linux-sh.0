From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 14 Sep 2012 20:11:00 +0000
Subject: GPIO request failure with PCF pinmux
Message-Id: <6045802.ynsOILKLIK@avalon>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Paul,

I ran into an issue with GPIO and pinmuxing in the TPU PWM driver.

The driver needs to switch the PWM pin between GPIO and function at runtime. 
To do so, I use the PWM pin GPIO (GPIO_PORT202) and the associated function 
GPIO (GPIO_FN_TPU0TO2_PORT202).

The driver configures the pin as a GPIO output when loaded with

	gpio_request_one(GPIO_PORT202, GPIOF_INIT_LOW);

This results in a call to sh_pfc_gpio_request_enable() followed by a call to 
sh_pfc_reconfig_pin() for GPIO 202. The later changes the pinmux type from 
PINMUX_TYPE_GPIO (2) to PINMUX_TYPE_OUTPUT (3).

I then call gpio_free(GPIO_PORT202) and gpio_request(GPIO_FN_TPU0TO2_PORT202) 
to switch from GPIO to function. The former calls sh_pfc_gpio_disable_free:() 
on GPIO 202.

When I later call gpio_free(GPIO_FN_TPU0TO2_PORT202) and 
gpio_request_one(GPIO_PORT202, GPIOF_INIT_LOW), the call to 
sh_pfc_gpio_request_enable() fails with

pinctrl-sh_pfc pinctrl: Unsupported mux type (3), bailing...
pinctrl-sh_pfc pinctrl-sh_pfc: request() failed for pin 202
pinctrl-sh_pfc pinctrl-sh_pfc: pin-202 (pinctrl-sh_pfc) status -524

You're more familiar with pinmux than I am. Am I doing something wrong, or is 
there a bug in the PFC pinmux implementation ?

-- 
Regards,

Laurent Pinchart

