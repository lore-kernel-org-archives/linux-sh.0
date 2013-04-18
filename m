From: Daniel Lezcano <daniel.lezcano@linaro.org>
Date: Thu, 18 Apr 2013 13:35:49 +0000
Subject: Re: [PATCH 1/4] SH: cpuidle: remove pointless initialization
Message-Id: <516FF6B5.4070508@linaro.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1366205577-11632-1-git-send-email-daniel.lezcano@linaro.org> <20130418011816.GD4511@verge.net.au> <516FBA4C.6020100@linaro.org> <20130418133408.GF20929@verge.net.au>
In-Reply-To: <20130418133408.GF20929@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Simon Horman <horms@verge.net.au>
Cc: lethal@linux-sh.org, rjw@sisk.pl, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, patches@linaro.org

On 04/18/2013 03:34 PM, Simon Horman wrote:
> On Thu, Apr 18, 2013 at 11:18:04AM +0200, Daniel Lezcano wrote:
>> On 04/18/2013 03:18 AM, Simon Horman wrote:
>>> On Wed, Apr 17, 2013 at 03:32:54PM +0200, Daniel Lezcano wrote:
>>>> The driver is a global static variable automatically initialized to ze=
ro.
>>>>
>>>> Removing the useless initialization in the init function.
>>>>
>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>
>>> Hi Daniel,
>>>
>>> All four patches in this series seem reasonable to me.
>>>
>>> Acked-by: Simon Horman <horms+renesas@verge.net.au>
>>>
>>> Please let me know if I should take them through my renesas tree.
>>
>> If you are ok with that, is it possible to take them through the
>> linux-pm tree ? So the cpuidle drivers are synced and I can continue the
>> code consolidation ?
>=20
> Yes, I am ok with them going through the linux-pm tree.

Thanks !


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for ARM=
 SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

