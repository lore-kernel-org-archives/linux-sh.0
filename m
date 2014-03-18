From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 18 Mar 2014 20:17:46 +0000
Subject: Re: [PATCH] sh_eth: ensure pm_runtime cannot suspend the device during init
Message-Id: <5328B7F7.8060109@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1394823605-31883-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1394823605-31883-1-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 03/17/2014 05:01 PM, Ben Dooks wrote:

>>>>> I have yet to ascertain how this ends up happening with device probe,
>>>>> it seems to be very dependant on the code.

>>>> Adding a WARN() in cpg_mstp_clock_endisable():

[...]

>>> this explains it, the call to stats causes a get_sync/put_sync which
>>> puts the device into a state where it /could/ be suspended and thus
>>> does get suspended in this case from the pm code.

>>> I'm not /sure/ why the pm_runtime code is not protecting against
>>> running this when a device probe is in progress, but it seems the
>>> best thing is to ensure that we always do a get/put sync in the
>>> driver to ensure we have a reference during probe.

>> Wouldn't it be better to register the MDIO bus before registering the network
>> device ? It looks like the current order is prone to race conditions.

> Not sure, requires input?

    People say that the driver should be ready to receive the ndo_open() 
method call even before register_netdev() returns. I have prepared the patch 
to probe MDIO before calling register_netdev() now, need to sanity test it.

>> Another potential issue, does the network layer guarantee that the device will
>> always be opened by an .ndo_open() call before performing any MDIO operation ?
>> sh_mmd_ctrl, sh_set_mdio and sh_get_mdio access sh-eth registers, could we be
>> missing runtime PM calls in those call paths ?

> I'm not sure if there is any guarantee, I don't think the PHY driver
> does any sort of open on probe. I do have a patch to ensure that the
> MDIO operations are wrapped with pm_runtime_{get,put}_sync() calls as
> the probe of the PHY often fails without it.

    Respin this patch please (addressing my comments), so that DaveM could 
take it.

WBR, Sergei

