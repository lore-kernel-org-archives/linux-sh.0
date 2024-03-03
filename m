Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE2D33E5
	for <linux-sh@vger.kernel.org>; Sun,  3 Mar 2024 04:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709439959; cv=none; b=i2vEdUF4Otfr3ENLdbkpyjdZAsj9397/mwMi7Cvh3bpJud8cZQCDtqySLhN09ajyigNbUURfQPNYIz6qvDtTtvP6bJ0pfLsz9U062tLfKIhuB4TESocCItfSH7gQo02aN2OSSmerYhK25Tlj+y06e2zY3rVzOi4au4Y8NvVT7is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709439959; c=relaxed/simple;
	bh=JGEMTSw+h3Tskj6UQtxs7o4Z1kUEuraMEQeoCqx4kXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uXwkSKejIh87QhAamK3Dz+aGNALgoxICbCSGZci8HJia36oVqTZeA9pl7oey77rD/zU6EA9Eh8/sydTK+GNyG3/+dK1+C3P9KA0ju90ClvZ890w7rAs0ZW4EGpig9xGLgDwuisEVMBSUIz/viGhc28K/LS//rDwG7rtpfFmeY4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hukGhqiu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hukGhqiu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709439956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4tP8cj/EkhDB5rHKjBPyA2CO06IZFpZarql6Oarbplo=;
	b=hukGhqiuJeFgRdHct88YXKqESX6QvXkAPx3+Q9nia7VjetwjGg43G0Z8XJtNE4YqFzriJi
	WUFrBPQyIuqhJqUrin+E0iBNWZlid6dKcjX7T5L3AYGMqaIvZ9mdi1DcoYATeKXYq4Xxv7
	5MtVyHiexllB7PVWqzkrmRjJETRNUpk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-408-coMkeA93Ow-062Wa0M69gA-1; Sat,
 02 Mar 2024 23:25:53 -0500
X-MC-Unique: coMkeA93Ow-062Wa0M69gA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5D71429AB40A;
	Sun,  3 Mar 2024 04:25:53 +0000 (UTC)
Received: from [10.22.32.39] (unknown [10.22.32.39])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 994452166B31;
	Sun,  3 Mar 2024 04:25:52 +0000 (UTC)
Message-ID: <87fe0004-0e53-4b7a-b19d-c6b37c8db8dc@redhat.com>
Date: Sat, 2 Mar 2024 23:25:51 -0500
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH/RFC] locking/spinlocks: Make __raw_* lock ops static
Content-Language: en-US
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Arnd Bergmann <arnd@arndb.de>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
References: <c395b02613572131568bc1fd1bc456d20d1a5426.1709325647.git.geert+renesas@glider.be>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <c395b02613572131568bc1fd1bc456d20d1a5426.1709325647.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On 3/1/24 15:43, Geert Uytterhoeven wrote:
> sh/sdk7786_defconfig (CONFIG_GENERIC_LOCKBREAK=y and
> CONFIG_DEBUG_LOCK_ALLOC=n):
>
> kernel/locking/spinlock.c:68:17: warning: no previous prototype for '__raw_spin_lock' [-Wmissing-prototypes]
> kernel/locking/spinlock.c:80:26: warning: no previous prototype for '__raw_spin_lock_irqsave' [-Wmissing-prototypes]
> kernel/locking/spinlock.c:98:17: warning: no previous prototype for '__raw_spin_lock_irq' [-Wmissing-prototypes]
> kernel/locking/spinlock.c:103:17: warning: no previous prototype for '__raw_spin_lock_bh' [-Wmissing-prototypes]
> kernel/locking/spinlock.c:68:17: warning: no previous prototype for '__raw_read_lock' [-Wmissing-prototypes]
> kernel/locking/spinlock.c:80:26: warning: no previous prototype for '__raw_read_lock_irqsave' [-Wmissing-prototypes]
> kernel/locking/spinlock.c:98:17: warning: no previous prototype for '__raw_read_lock_irq' [-Wmissing-prototypes]
> kernel/locking/spinlock.c:103:17: warning: no previous prototype for '__raw_read_lock_bh' [-Wmissing-prototypes]
> kernel/locking/spinlock.c:68:17: warning: no previous prototype for '__raw_write_lock' [-Wmissing-prototypes]
> kernel/locking/spinlock.c:80:26: warning: no previous prototype for '__raw_write_lock_irqsave' [-Wmissing-prototypes]
> kernel/locking/spinlock.c:98:17: warning: no previous prototype for '__raw_write_lock_irq' [-Wmissing-prototypes]
> kernel/locking/spinlock.c:103:17: warning: no previous prototype for '__raw_write_lock_bh' [-Wmissing-prototypes]
>
> Fix this by making the __raw_* lock ops static.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Compile-tested only.
>
> Is SH really the only SMP platform where CONFIG_GENERIC_LOCKBREAK=y?
> ---
>   kernel/locking/spinlock.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/locking/spinlock.c b/kernel/locking/spinlock.c
> index 8475a0794f8c5ad2..7009b568e6255d64 100644
> --- a/kernel/locking/spinlock.c
> +++ b/kernel/locking/spinlock.c
> @@ -65,7 +65,7 @@ EXPORT_PER_CPU_SYMBOL(__mmiowb_state);
>    * towards that other CPU that it should break the lock ASAP.
>    */
>   #define BUILD_LOCK_OPS(op, locktype)					\
> -void __lockfunc __raw_##op##_lock(locktype##_t *lock)			\
> +static void __lockfunc __raw_##op##_lock(locktype##_t *lock)		\
>   {									\
>   	for (;;) {							\
>   		preempt_disable();					\
> @@ -77,7 +77,7 @@ void __lockfunc __raw_##op##_lock(locktype##_t *lock)			\
>   	}								\
>   }									\
>   									\
> -unsigned long __lockfunc __raw_##op##_lock_irqsave(locktype##_t *lock)	\
> +static unsigned long __lockfunc __raw_##op##_lock_irqsave(locktype##_t *lock) \
>   {									\
>   	unsigned long flags;						\
>   									\
> @@ -95,12 +95,12 @@ unsigned long __lockfunc __raw_##op##_lock_irqsave(locktype##_t *lock)	\
>   	return flags;							\
>   }									\
>   									\
> -void __lockfunc __raw_##op##_lock_irq(locktype##_t *lock)		\
> +static void __lockfunc __raw_##op##_lock_irq(locktype##_t *lock)	\
>   {									\
>   	_raw_##op##_lock_irqsave(lock);					\
>   }									\
>   									\
> -void __lockfunc __raw_##op##_lock_bh(locktype##_t *lock)		\
> +static void __lockfunc __raw_##op##_lock_bh(locktype##_t *lock)		\
>   {									\
>   	unsigned long flags;						\
>   									\

This may not work if CONFIG_GENERIC_LOCKBREAK is defined. We had been 
talking about taking out CONFIG_GENERIC_LOCKBREAK before. See the thread 
in [1]. However, we didn't proceed further at that time as we weren't 
totally sure if there were still some configurations that required 
CONFIG_GENERIC_LOCKBREAK.

[1] https://lore.kernel.org/lkml/20211022120058.1031690-1-arnd@kernel.org/

Anyway, without taking out CONFIG_GENERIC_LOCKBREAK, the proper way to 
fix this issue is probably to declare the proper function prototypes in 
include/linux/rwlock_api_smp.h and include/linux/spinlock_api_smp.h when 
CONFIG_GENERIC_LOCKBREAK is defined.

Cheers,
Longman

