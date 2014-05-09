From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 09 May 2014 22:57:12 +0000
Subject: Re: [PATCH v3 2/7] adv7180: add of match table
Message-Id: <536D5D48.5010801@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1397471802-27216-3-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1397471802-27216-3-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 05/09/2014 11:01 AM, Geert Uytterhoeven wrote:

>>>> Add a proper of match id for use when the device is being bound via
>>>> device tree, to avoid having to use the i2c old-style binding of the

> "to avoid having to use the i2c old-style binding"

    Ah, I'd probably missed these words.

>>>> device.

>>>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

>>>      From looking at of_i2c_register_devices() in drivers/i2c/i2c-core.c, I
>>> got
>>> an impression we don't need this patch. This function builds the I2C
>>> device
>>> name by calling of_modalias_node() which just strips the vendor prefix (if
>>> any) from the "compatible" prop.

>>     Yeah, I was able to get the ADV7180 device from DT probed without this
>> patch. So, no, we don't need the patch.

> So it works without, but it's better to use the full name.

    OK, I'll see how it binds to the driver with this patch applied...

> Gr{oetje,eeting}s,
>                          Geert

WBR, Sergei

