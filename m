From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Mon, 17 Mar 2014 09:41:33 +0000
Subject: Re: [PATCH] sh_eth: ensure pm_runtime cannot suspend the device during init
Message-Id: <5326C34D.2020304@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1394823605-31883-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1394823605-31883-1-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 17/03/14 09:22, Geert Uytterhoeven wrote:
> Hi Ben,
>
> On Fri, Mar 14, 2014 at 8:00 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>> It seems the pm_rumtime work queue is causing the device to be suspended
>> during initialisation, thus the initialisation may not be able to access
>> registers properly. Use pm_runtime_get_sync() and pm_runtime_put_sync()
>> to ensure that the pm system does not suspend it during the probe() call.
>>
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>
> Thanks, this fixes the "imprecise external abort" on Koelsch.
>
> Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks, will consider sending this to the netdev list later.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
