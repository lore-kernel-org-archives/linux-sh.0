From: Rob Lee <rob.lee@linaro.org>
Date: Wed, 21 Mar 2012 04:45:04 +0000
Subject: Re: [PATCH v8 0/8] Consolidate cpuidle functionality
Message-Id: <CAMXH7KGs7TsgvVbaher2oMW=s=Y+5TMnQcffDG8kcdAfn7z8zg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1332274969-15782-1-git-send-email-rob.lee@linaro.org>
 <87wr6evmnn.fsf@ti.com>
In-Reply-To: <87wr6evmnn.fsf@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Tue, Mar 20, 2012 at 7:10 PM, Kevin Hilman <khilman@ti.com> wrote:
> Hi Rob,
>
> Robert Lee <rob.lee@linaro.org> writes:
>
>> This patch series moves various functionality duplicated in platform
>> cpuidle drivers to the core cpuidle driver. Also, the platform irq
>> disabling was removed as it appears that all calls into
>> cpuidle_call_idle will have already called local_irq_disable().
>>
>> These changes have been pulled into linux-next.
>>
>> Len, Andrew, can a request be made for Linus to pull these changes?
>>
>> Acked-by: Jean Pihet<j-pihet@ti.com> =A0(v6)
>> Tested-by: Jean Pihet<j-pihet@ti.com> =A0(v6, omap3)
>> Tested-by: Amit Daniel<amit.kachhap@linaro.org> =A0(v6, Exynos4)
>> Tested-by: Robert Lee<rob.lee@linaro.org> =A0(imx51, imx6q)
>
> Note that there's a space missing between the name and email in these
> tags (and for Deepthi's below also.) =A0That seems to exist in all the
> patches.
>

Thanks.  This is now fixed in my pull tree.

>> Reviewed-by: Kevin Hilman <khilman@ti.com>
>
> For my Reviewed-by, it only applies to the core code and the OMAP
> changes. =A0I haven't reviewed the other platform-specific drivers. =A0I
> believe the same applies to Jean Pihet who works with me on OMAP.
>
>> Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Reviewed-by: Deepthi Dharwar<deepthi@linux.vnet.ibm.com> (core cpuidle o=
nly)
>
> Looks like you never heard from anyone actively working on at91,
> shmobile, kirwood or davinci.
>
> I'm not sure we should merge those platform-specific changes without an
> ack from those platform maintainers.
>
> For 3.4, maybe we should just merge the core code and the platforms that
> have been reviewed/ack'd, and for 3.5, spent some time nagging the other
> platform maintainers to review and test.
>
> Kevin
>
