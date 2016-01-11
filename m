From: Rob Herring <robh@kernel.org>
Date: Mon, 11 Jan 2016 02:52:00 +0000
Subject: Re: [RFC v2 2/4] dt-bindings: i2c: mux: demux-pinctrl: add bindings
Message-Id: <20160111025200.GA5993@rob-hp-laptop>
List-Id: <linux-sh.vger.kernel.org>
References: <1452088285-6427-1-git-send-email-wsa@the-dreams.de>
 <1452088285-6427-3-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1452088285-6427-3-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Jan Luebbe <jlu@pengutronix.de>

On Wed, Jan 06, 2016 at 02:51:23PM +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> These bindings allow an I2C bus to switch between multiple masters. This
> is not hot-swichting because connected I2C slaves will be

s/swichting/switching/

> re-instantiated. It is meant to select the best I2C core at runtime once
> the task is known. Example: Prefer i2c-gpio over another I2C core
> because of HW errata affetcing your use case.

This seems okay to me. I don't like not having the i2c devices under the 
i2c controller, but not really much we can do about that.

I have another usecase which might end up needing a similar structure 
as this. That is the whole question of how to deal with capes, hats, 
shields and various daughterboards. For I2C devices on a daughterboard, 
we need to be able to have a DT overlay for the daughterboard described 
in terms of the connector(s) and independent of the host. Then the 
base DT needs to define the mapping from the connector to the host 
controller. A complicating factor would be having devices on the same 
bus but split across the main and daughter boards. I don't see anything 
specific to change here, but just want to throw that out.

[...]

> +
> +Changing I2C controllers:
> +
> +The created mux-device will have a file "cur_master" in its sysfs-entry. Write
> +0 there for the first master listed in the "i2c-parent" property, 1 for the
> +second etc. Reading the file will give you a list with the active master
> +marked. Example from a Renesas Lager board:

This is Linux specific and should not be in the binding. You also need 
sysfs docs for these sysfs files.

Rob
