From: Rob Herring <robh@kernel.org>
Date: Fri, 15 Jan 2016 02:03:33 +0000
Subject: Re: [PATCH 1/3] dt-bindings: i2c: mux: demux-pinctrl: add bindings
Message-Id: <20160115020333.GA3139@rob-hp-laptop>
List-Id: <linux-sh.vger.kernel.org>
References: <1452695369-29413-1-git-send-email-wsa@the-dreams.de>
 <1452695369-29413-2-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1452695369-29413-2-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Jan Luebbe <jlu@pengutronix.de>

On Wed, Jan 13, 2016 at 03:29:27PM +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> These bindings allow an I2C bus to switch between multiple masters. This
> is not hot-switching because connected I2C slaves will be
> re-instantiated. It is meant to select the best I2C core at runtime once
> the task is known. Example: Prefer i2c-gpio over another I2C core
> because of HW errata affecting your use case.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  .../ABI/testing/sysfs-platform-i2c-demux-pinctrl   |  23 ++++
>  .../devicetree/bindings/i2c/i2c-demux-pinctrl.txt  | 136 +++++++++++++++++++++
>  2 files changed, 159 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-platform-i2c-demux-pinctrl
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-demux-pinctrl.txt

Acked-by: Rob Herring <robh@kernel.org>
