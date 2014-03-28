From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Fri, 28 Mar 2014 19:25:51 +0000
Subject: Re: [PATCH v5] sh_eth: ensure pm_runtime cannot suspend the device during init
Message-Id: <5335CCBF.8030606@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1395400154-25710-1-git-send-email-ben.dooks@codethink.co.uk> <20140328.142606.2032782733436495474.davem@davemloft.net>
In-Reply-To: <20140328.142606.2032782733436495474.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@lists.codethink.co.uk, netdev@vger.kernel.org, linux-sh@vger.kernel.org, sergei.shtylyov@cogentembedded.com, laurent.pinchart+renesas@ideasonboard.com

On 28/03/14 18:26, David Miller wrote:
> From: Ben Dooks <ben.dooks@codethink.co.uk>
> Date: Fri, 21 Mar 2014 12:09:14 +0100
>
>> The pm_rumtime work queue is causing the device to be suspended during
>> initialisation, thus the initialisation may not be able to access registers
>> properly. As the code is called from a work queue, it is possible that this
>> is not seen from certain configurations/builds due to the asynchronos
>> nature of the code.
>>
>> Another issue has also been found where the network device registration
>> calls back into the driver thus causing further pm_runtime calls that
>> also caused issues with the MDIO bus code. This has now been checked
>> and is the only place the MDIO can be called without the device open.
>>
>> Use pm_runtime_get_sync() and pm_runtime_put() to ensure that the
>> pm system does not suspend it during the probe() call and remove the
>> now unnecessary pm_runtime_resume() call. Also add a call in the error
>> path to call pm_runtime_disable().
>>
>> This fixes the external abort that can cause /sbin/init or other such
>> init processed to die.
>>
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>> Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> What tree is this against?  It doesn't apply cleanly to 'net'.

I thought it was against the net next tree, given the number of patches
that are currently being applied to the sh_eth driver.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
