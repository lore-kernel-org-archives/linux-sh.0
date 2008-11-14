From: Steve.Glendinning@smsc.com
Date: Fri, 14 Nov 2008 13:34:50 +0000
Subject: Re: smsc911x in 2.6.29
Message-Id: <OF2BAA41EA.301A6F50-ON80257501.0049F028-80257501.004A9FC1@smsc.com>
List-Id: <linux-sh.vger.kernel.org>
References: <OF18129353.0F9B8038-ON802574F9.003C4672-802574F9.003D1A48@smsc.com>
In-Reply-To: <OF18129353.0F9B8038-ON802574F9.003C4672-802574F9.003D1A48@smsc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Nobuhiro,

The second patch in my patchset adds support for dynamic bus 
configuration, so the platform config must specify its bus width at 
runtime.  I'm merging this patch through netdev, it should be queued up 
for .29.

You removed this support from the sh platform patches (.phy_interface 
member of smsc911x_config):

-static struct smc911x_platdata smc911x_info = {
-                .flags = SMC911X_USE_32BIT,
-                .irq_flags = IRQF_TRIGGER_LOW,
+static struct smsc911x_platform_config smsc911x_config = {
+                .irq_polarity = SMSC911X_IRQ_POLARITY_ACTIVE_LOW,
+                .irq_type = SMSC911X_IRQ_TYPE_OPEN_DRAIN,
+                .flags = SMSC911X_USE_32BIT,
+                .phy_interface = PHY_INTERFACE_MODE_MII,
 };

Can you add this back?  With the dynamic bus config patch applied, the 
driver will BUG() if neither SMSC911X_USE_32BIT nor SMSC911X_USE_16BIT is 
set.

Regards,
--
Steve Glendinning
SMSC GmbH
m: +44 777 933 9124
e: steve.glendinning@smsc.com





Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com> 
Sent by: iwamatsu.nobuhiro@renesas.com
14/11/2008 06:26

To
Steve Glendinning/SMSC@SMSC
cc
Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, linux-sh@vger.kernel.org, 
lethal@linux-sh.org, damm@igel.co.jp, shimoda.yoshihiro@renesas.com, Ian 
Saturley/SMSC@SMSC
Subject
Re: smsc911x in 2.6.29






Hi, Steve.

I checked your patch on ap325rxa board.
Your patch had compile error. I fixed this.
When fixed this patch, this board work fine.

Rsk7203 has hardware problem. It doesn't yet work.
It may take time.

I will send patch about ap325rxa, magicpanelr2 and rsk7203.

Best regards,
  Nobuhiro

Nobuhiro Iwamatsu wrote:
> Hi, Steve.
> 
> 2008/11/6  <Steve.Glendinning@smsc.com>:
>> Hi all,
>>
>> I recently posted a patchset on netdev to replace smc911x with a new
>> vendor-supported smsc911x driver:
>>
>>    http://marc.info/?l=linux-netdev&m2588138425309&w=4
>>
>> Jeff Garzik has merged the driver itself for net-next (2.6.29).
>>
>> 3 of the patches convert sh platforms (rsk7203, ap325rxa & 
magicpanelr2)
>> from one driver to the other, but I don't have access to any of these
>> platforms to test.  Can anyone here help?
>>
>> Please let me know if anyone wants me to re-send them the whole 
patchset
>> (6 patches).
> 
> OK,  I will test and report about rsk7203 and ap325rxa.




