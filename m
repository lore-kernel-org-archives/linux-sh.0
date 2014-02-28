From: Benoit Cousson <bcousson@baylibre.com>
Date: Fri, 28 Feb 2014 14:15:32 +0000
Subject: Re: [RFC 0/4] ARM: shmobile: Add CPUFreq support for r8a7790-lager platform
Message-Id: <53109A04.1010508@baylibre.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1393456190-7870-1-git-send-email-bcousson@baylibre.com>
In-Reply-To: <1393456190-7870-1-git-send-email-bcousson@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Salut Laurent,

On 28/02/2014 14:53, Laurent Pinchart wrote:
> Hi Benoit,
>
> On Thursday 27 February 2014 00:09:46 Benoit Cousson wrote:
>> Hi Magnus,
>>
>> This not-yet-ready-to-merge series is adding CPUFreq support to Lager bo=
ard.
>>
>> Due to the missing data for the OPP voltage values, a safe 1.0v value is
>> used for all OPPs.
>>
>> At least this series can be used by Laurent to test the z-clock CCF node
>> and the KICK bit fix I've just sent.
>>
>> Bottom-line, no real DVFS so far, but just DFS :-)
>>
>> Please note that this series is safe even in the case of Cortex A7 boot
>> since the cpufreq-cpu0 driver is using the physical CPU@0 device node.
>> In the case of CA7 boot, the first cpu will be the CPU@100, and thus
>> the driver will fail at probe time due to the lack of CPU@0.
>
> I'd like to test that on r8a7791, can I use the same parameters (voltages,
> frequencies and OPPs) ?

For the frequency, it will be similar since the r8a7791 seems to run at=20
1.3 GHz as well.

For the voltage, it should be similar, but I do not have any information=20
and I'm not sure that the regulator used on the Koelsh board is the same=20
(da9210).
It might be safer to remove the phandle to the regulator.
I hope the cpufreq-cpu0 driver probe will not fail becasue of that.

Regards,
Benoit

--=20
Beno=EEt Cousson
BayLibre
Embedded Linux Technology Lab
www.baylibre.com
