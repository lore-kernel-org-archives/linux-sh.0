From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Fri, 07 Mar 2014 16:05:04 +0000
Subject: Re: [PATCH RFC] ARM: shmobile: r8a7791 legacy: Disable RMSTP clocks
Message-Id: <5319EE30.8000107@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1394135648-10193-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1394135648-10193-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 07/03/14 15:50, Laurent Pinchart wrote:
> Hi Ben,
>
> On Friday 07 March 2014 15:44:20 Ben Dooks wrote:
>> On 07/03/14 15:23, Laurent Pinchart wrote:
>>> On Thursday 06 March 2014 20:54:08 Geert Uytterhoeven wrote:
>>>> From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
>>>>
>>>> Each module clock has actually two disable bits: one for the System Core
>>>> (ARM) in an SMSTPCRx register, and one for the Realtime Core (SH) in an
>>>> RMSTPRx register. Currently we don't touch the bits meant for the
>>>> Realtime Core, so some clocks may inadvertently be enabled and still run,
>>>> wasting power, while they're disabled in the SMSTPCRx register.
>>>> The actual state of the clock is indicated in the corresponding status
>>>> register.
>>>>
>>>> Set the disable bits for the Realtime Core for all module clocks we
>>>> currently care about to fix this. After this, e.g. QSPI fails to work if
>>>> we deliberately keep its clock gated.
>>>>
>>>> Thanks to Laurent for the Realtime Core hint.
>>>>
>>>> Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
>>>> ---
>>>> This is a quick hack, NOT to be applied!
>>>>
>>>> Notes/Questions/...:
>>>>     - The good news is that the system booted fine, hence so far I didn't
>>>>       notice any clocks that were not enabled correctly in our driver
>>>>       code, for both legacy and DT case (I used a slightly different
>>>>       version of this hack to test the DT case).
>>>>
>>>>     - After bootup, the following clocks seem to be enabled for the
>>>>       Realtime Core:
>>>>         SCIFA0-2, SCIFB0-2, QSPI, MSIOF0-2, I2C0-5
>>>>
>>>>     - The following clocks were disabled for the Realtime Core:
>>>>         LVDS0, DU0-1, SCIF0-5, SCIFA3-5, SDHI0-2, CMT0, Thermal, Ether,
>>>>         VIN0-1, SATA0-1
>>>>
>>>>     - These are only the clocks we're currently using. There exist other
>>>>       clocks, I did not check their states.
>>>>
>>>>     - Just setting all RMSTPCRx registers to 0xffffffff is not an option,
>>>>       as reserved bits should be written back using their read values.
>>>>
>>>>     - Should we add a new enable_reg to struct clk for the legacy case? Or
>>>>       just disable them at initialization time, without enlarging struct
>>>>       clk?
>>>>
>>>>     - Add more registers to the bindings for the DT case?
>>>>     - How to tell the system that it should (not) disable the RMSTP
>>>>       clocks? Someone may want to run something on the SH core, and we
>>>>       don't want to interfere with that.
>>>
>>> Those are tricky questions. RMSTPCRs are supposed to be managed by the
>>> SH-4A core. If the SH-4A core isn't booted the only option we have is to
>>> manage them elsewhere. In that case the registers should be configured at
>>> boot time to disable all modules from the SH-4A side. This could be done
>>> either when booting the kernel, or in the boot loader.
>>>
>>> If the SH-4A core is booted by Linux we could require the SH-4A code to
>>> disable all unused clocks, but we could also do so before booting it
>>> without any drawback (I expect the SH-4A firmware to enable the clocks it
>>> needs).
>>>
>>> The SH-4A core could be booted first, and then only boot the ARM cores
>>> running Linux. I don't know if that configuration is commonly used, or
>>> even supported, but in theory that should be possible. In that case the
>>> Linux kernel must not touch the RMSTPCRs.
>>>
>>> We could disable all realtime clocks from the Linux kernel at boot time
>>> (with a way to bypass that depending on whether booting the SH-4A first
>>> is a use case we need to support), or decide to leave this to the boot
>>> loader.
>>
>> I agree with Laurent, we don't really have a good way yet to know
>> if the SH-4A is going to be used.
>
> Are you aware of any use case where SH-4A would be the main core and would
> then boot Linux on the ARM cores ?

I've been in discussion on a case where the SH core may have been
booted by something else before Linux was run. We're currently not
sure how this is going to be played out (SH loaded from Linux, or
from somewhere else)

>> My preference would be to either fix it in the bootloader (possibly
>> add a script in before loading the kernel).
>
> Either that, or what ? :-)
>


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
