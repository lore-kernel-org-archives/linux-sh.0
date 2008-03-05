From: Richard Purdie <rpurdie@rpsys.net>
Date: Wed, 05 Mar 2008 22:07:44 +0000
Subject: Re: [HP J6xx] - Touchscreen still not working with tslib
Message-Id: <1204754864.8110.192.camel@dax.rpnet.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20080305220015.a30f01fa.Kristoffer.Ericson@Gmail.com>
In-Reply-To: <20080305220015.a30f01fa.Kristoffer.Ericson@Gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, 2008-03-05 at 22:00 -0800, Kristoffer Ericson wrote:
> 	if (touched) {
> 		input_report_abs(dev, ABS_X, x);
> 		input_report_abs(dev, ABS_Y, y);
> 		input_report_abs(dev, ABS_PRESSURE, 1);
> 		input_report_key(dev, BTN_TOUCH, 1);
> 		printk(KERN_INFO "ts: PRESS x=%d, y=%d\n", x, y);
> 	} else {
> 		input_report_key(dev, ABS_PRESSURE, 0);

input_report_key(dev, BTN_TOUCH, 0);
is missing here. 

Make sure the pressure release event is working with a printk too!

> 	dev->dev.parent = &pdev->dev;
> 	dev->evbit[0] = BIT_MASK(EV_ABS) | BIT_MASK(EV_KEY);
> 	dev->absbit[0] = BIT_MASK(ABS_X) | BIT_MASK(ABS_Y) | BIT_MASK(ABS_PRESSURE);
> 	dev->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
> 
> 	input_set_abs_params(dev, ABS_X, 40, 950, 0, 0);
> 	input_set_abs_params(dev, ABS_Y, 80, 910, 0, 0);

Does adding a:

input_set_abs_params(dev, ABS_PRESSURE, 0, 1, 0, 0);

here help?

Regards,

Richard

