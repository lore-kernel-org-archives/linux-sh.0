From: Rob Lee <rob.lee@linaro.org>
Date: Mon, 12 Mar 2012 18:45:15 +0000
Subject: Re: [git pull] Consolidate cpuidle functionality
Message-Id: <CAMXH7KFrMVzn1tVxWzm1yOVuiaVJoo7x_NHm6XPo3rPDtuM=tQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1330562578-3410-1-git-send-email-rob.lee@linaro.org>
 <87y5reivhb.fsf@ti.com>
 <CAMXH7KEwQM37R++8moXB8Q41_fBXOnVY2hXJGFQmTQ20oeFPEQ@mail.gmail.com>
 <20120309174017.081154936f57039b37c50435@canb.auug.org.au>
In-Reply-To: <20120309174017.081154936f57039b37c50435@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Len and Andrew,

Please consider this an official merge request of this cpuidle
patchset for v3.4.

There were two small conflicts Stephen Rothwell found when merging to
linux-next.  The first conflict is with patch 1/9 in the
drivers/cpuidle/cpuidle.c file which is trivially to resolve.  I'm
told this fixup is trivially enough to not require anyone to carry it.

The second is with patch 2/9 in mach-at91/cpuidle.c due to some minor
cleanup changes.  The fix is also pretty simple but I'm waiting to
hear back about who will carry it.

Please let me know if you need any other action or information on my part.

Thanks,
Rob


On Fri, Mar 9, 2012 at 12:40 AM, Stephen Rothwell <sfr@canb.auug.org.au> wr=
ote:
> Hi Rob,
>
> On Thu, 8 Mar 2012 19:58:23 -0600 Rob Lee <rob.lee@linaro.org> wrote:
>>
>> =A0 git://git.linaro.org/people/rob_lee/linux.git cpuidle_consol_pull
>>
>> These changes move various functionality duplicated in platform
>> cpuidle drivers to the core cpuidle driver and common arch arm code. Als=
o,
>> the irq disabling in the platform code was removed as all calls into
>> cpuidle_call_idle() will have already called local_irq_disable().
>>
>> This patchset is bisect safe. =A0Also, the core cpuidle and arch changes=
 of the
>> first commit do not require any changes to the arch and platform cpuidle
>> drivers, though those arch and platform change should be made to take
>> advantage of the new consolidation function.
>>
>> Stephen, this patch has been reviewed, tested, and ACK'd per the list ab=
ove but
>> cpuidle maintainer Len Brown has been out on vacation for a couple of we=
eks so
>> I am sending you this pull request as time is running out to get this in=
to
>> v3.4. =A0I've had a brief communication with Andrew Morton about
>> this as well so he is aware of this situation. =A0I am fairly new to the
>> community so please let me know if you see anything that needs my attent=
ion or
>> anything I should be doing differently.
>
> I will add this tree from today. =A0Lets see if anyone screams.
>
> Thanks for adding your subsystem tree as a participant of linux-next. =A0=
As
> you may know, this is not a judgment of your code. =A0The purpose of
> linux-next is for integration testing and to lower the impact of
> conflicts between subsystems in the next merge window.
>
> You will need to ensure that the patches/commits in your tree/series have
> been:
> =A0 =A0 * submitted under GPL v2 (or later) and include the Contributor's
> =A0 =A0 =A0 =A0Signed-off-by,
> =A0 =A0 * posted to the relevant mailing list,
> =A0 =A0 * reviewed by you (or another maintainer of your subsystem tree),
> =A0 =A0 * successfully unit tested, and
> =A0 =A0 * destined for the current or next Linux merge window.
>
> Basically, this should be just what you would send to Linus (or ask him
> to fetch). =A0It is allowed to be rebased if you deem it necessary.
>
> --
> Cheers,
> Stephen Rothwell
> sfr@canb.auug.org.au
>
> Legal Stuff:
> By participating in linux-next, your subsystem tree contributions are
> public and will be included in the linux-next trees. =A0You may be sent
> e-mail messages indicating errors or other issues when the
> patches/commits from your subsystem tree are merged and tested in
> linux-next. =A0These messages may also be cross-posted to the linux-next
> mailing list, the linux-kernel mailing list, etc. =A0The linux-next tree
> project and IBM (my employer) make no warranties regarding the linux-next
> project, the testing procedures, the results, the e-mails, etc. =A0If you
> don't agree to these ground rules, let me know and I'll remove your tree
> from participation in linux-next.
