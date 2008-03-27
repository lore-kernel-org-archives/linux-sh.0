From: Andrew Morton <akpm@linux-foundation.org>
Date: Thu, 27 Mar 2008 22:07:37 +0000
Subject: Re: [PATCH] i2c: SuperH Mobile I2C Bus Controller V3
Message-Id: <20080327150737.be28a398.akpm@linux-foundation.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080325105559.GA30232@linux-sh.org>
In-Reply-To: <20080325105559.GA30232@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: i2c@lm-sensors.org, khali@linux-fr.org, magnus.damm@gmail.com, linux-sh@vger.kernel.org

On Tue, 25 Mar 2008 19:55:59 +0900
Paul Mundt <lethal@linux-sh.org> wrote:

> This is V3 of the SuperH Mobile I2C Controller Driver.

i386 allmodconfig:

ERROR: "clk_get_rate" [drivers/i2c/busses/i2c-sh_mobile.ko] undefined!
ERROR: "clk_get" [drivers/i2c/busses/i2c-sh_mobile.ko] undefined!
ERROR: "clk_put" [drivers/i2c/busses/i2c-sh_mobile.ko] undefined!
