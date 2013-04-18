From: Daniel Lezcano <daniel.lezcano@linaro.org>
Date: Thu, 18 Apr 2013 09:18:04 +0000
Subject: Re: [PATCH 1/4] SH: cpuidle: remove pointless initialization
Message-Id: <516FBA4C.6020100@linaro.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1366205577-11632-1-git-send-email-daniel.lezcano@linaro.org> <20130418011816.GD4511@verge.net.au>
In-Reply-To: <20130418011816.GD4511@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Simon Horman <horms@verge.net.au>
Cc: lethal@linux-sh.org, rjw@sisk.pl, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, patches@linaro.org

On 04/18/2013 03:18 AM, Simon Horman wrote:
> On Wed, Apr 17, 2013 at 03:32:54PM +0200, Daniel Lezcano wrote:
>> The driver is a global static variable automatically initialized to zero.
>>
>> Removing the useless initialization in the init function.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>=20
> Hi Daniel,
>=20
> All four patches in this series seem reasonable to me.
>=20
> Acked-by: Simon Horman <horms+renesas@verge.net.au>
>=20
> Please let me know if I should take them through my renesas tree.

If you are ok with that, is it possible to take them through the
linux-pm tree ? So the cpuidle drivers are synced and I can continue the
code consolidation ?

Thanks for the review.

  -- Daniel

>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for ARM=
 SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

