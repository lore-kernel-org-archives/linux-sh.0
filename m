From: Chris Metcalf <cmetcalf@tilera.com>
Date: Fri, 13 Jul 2012 16:46:11 +0000
Subject: Re: [PATCH] fork: fix error handling in dup_task()
Message-Id: <500050D3.2040403@tilera.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1342091093-1909-1-git-send-email-akinobu.mita@gmail.com> <20120712150623.06b2f71e.akpm@linux-foundation.org> <CAC5umyhPUZ_EVuMSFEzw5nYz6+DjkNLCe12Vvkx-9wig7nA+pA@mail.gmail.com>
In-Reply-To: <CAC5umyhPUZ_EVuMSFEzw5nYz6+DjkNLCe12Vvkx-9wig7nA+pA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, David Howells <dhowells@redhat.com>, Koichi Yasutake <yasutake.koichi@jp.panasonic.com>, linux-am33-list@redhat.com, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, Salman Qazi <sqazi@google.com>

On 7/13/2012 6:07 AM, Akinobu Mita wrote:
> 2012/7/13 Andrew Morton <akpm@linux-foundation.org>:
>> On Thu, 12 Jul 2012 20:04:53 +0900
>> Akinobu Mita <akinobu.mita@gmail.com> wrote:
>>
>>> The function dup_task() may fail at the following function calls in
>>> the following order.
>>>
>>> 0) alloc_task_struct_node()
>>> 1) alloc_thread_info_node()
>>> 2) arch_dup_task_struct()
>>>
>>> Error by 0) is not a matter, it can just return.  But error by 1)
>>> requires releasing task_struct allocated by 0) before it returns.
>>> Likewise, error by 2) requires releasing task_struct and thread_info
>>> allocated by 0) and 1).
>>>
>>> The existing error handling calls free_task_struct() and
>>> free_thread_info() which do not only release task_struct and
>>> thread_info, but also call architecture specific
>>> arch_release_task_struct() and arch_release_thread_info().
>>>
>>> The problem is that task_struct and thread_info are not fully
>>> initialized yet at this point, but arch_release_task_struct() and
>>> arch_release_thread_info() are called with them.
>>>
>>> For example, x86 defines its own arch_release_task_struct() that
>>> releases a task_xstate.  If alloc_thread_info_node() fails in
>>> dup_task(), arch_release_task_struct() is called with task_struct
>>> which is just allocated and filled with garbage in this error handling.
>>>
>>> This actually happened with tools/testing/fault-injection/failcmd.sh
>>>
>>>       # env FAILCMD_TYPE=FAil_page_alloc \
>>>               ./tools/testing/fault-injection/failcmd.sh --times=100 \
>>>               --min-order=3D0 --ignore-gfp-wait=3D0 \
>>>               -- make -C tools/testing/selftests/ run_tests
>>>
>>> In order to fix this issue, make free_{task_struct,thread_info}() not
>>> to call arch_release_{task_struct,thread_info}() and call
>>> arch_release_{task_struct,thread_info}() implicitly where needed.
>>>
>>> Default arch_release_task_struct() and arch_release_thread_info() are
>>> defined as empty by default.  So this change only affects the
>>> architectures which implement their own arch_release_task_struct() or
>>> arch_release_thread_info() as listed below.
>> This conflicts with Salman's fix (below) which is in linux-next via
>> Ingo's tree.
>>
>> It appears that we should drop Salman's patch altogether and use yours?
> Yes.  Salman's patch fixes error handling for x86, sh, and mn10300.
> But it doesn't fix for tile.  If tile's arch_release_thread_info() is
> called after setup_thread_stack(tsk, orig), it may release original
> task's step_state. (tsk->step_state will be cleared by tile's
> copy_thread() after dup_task_struct()).

Yes, I think Akinobu's patch is better.  Thanks.

--=20
Chris Metcalf, Tilera Corp.
http://www.tilera.com



