Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F373988E2;
	Thu, 17 Sep 2026 14:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789656526; cv=none; b=NozGlNVuPIT99i3KDxBYZugUdELb+CGSETxaVkg8V88tnLwmUQvEtX2tSCjQ0CH0dgJfikiccF6WP08AnDsjcHS1NdbRTujzR7OtQNUaS31NQPEVZUO4wFaaR/B5KbmW5P8VTpqSVD883byY8+76dAZFJMWMHSTsDjBfTZJq2ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789656526; c=relaxed/simple;
	bh=S1Nynt0BFZT2XlwieVvoLOYERJaogTw3CdTm+t9wg88=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=QT3dHmyvo0PRXZEe45LhsqA9umgc50fzwvuIC7v/r/AKjRadYaVk3unyWsnFu4UeRtX8KQ7evXAJbYFFQzEZ0KNGtluTtqMkeDQkmXVtNLdAGilc+Xcnng9OYRCFIocwnJvKABnVrvDqcWD/yYJPyInBEhEA5bl7hfyR5UCzH1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=AZ5LkLVA; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=IhIGaLkZ; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="AZ5LkLVA";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="IhIGaLkZ"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1789656352; bh=cR19NOwEHrL0x+Cw1KRK+wG
	oPhZS1Os2ZremNtqq9Ps=; b=AZ5LkLVAJ477b6736G8iO5Gn721CcqBI8xHooARsHdkrqRKMf8
	FTewoEEX0awObIvZkFhNscCm+VITa1hhw5+VOH1fIfhf2sG073ySi9lr9eAXk19qA9y+2NT6ekw
	EZfHx24PBoNamdt+ZKbjpZhKEJAtqawuQOGWmRZbR15ENC9VKhqBEoOEI26ZgM+8ieRVc0BrTdi
	If3O57cdrC+4sPxVo4KNVKh8imm8+2a6aDBwIzkZ9bQuI7/hwCnEFyVc+Z5ZDFsMj3SWTx9JyFO
	1xEOo1emZMiIsEDZC+HbDORu6R+oQKVzwgiZJiIm/LX3Z2jXwUEUYPZhrlyVDwk4bIQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1789656352; bh=cR19NOwEHrL0x+Cw1KRK+wG
	oPhZS1Os2ZremNtqq9Ps=; b=IhIGaLkZXFtovgOWXAWmF4RT3aS1zCHCodx3JYfCooGmK8IO4T
	2+62Hid8+FHMNm4wVuw2afTZokcU3yhcVVBw==;
Date: Thu, 17 Sep 2026 15:45:52 +0100
From: Bradley Morgan <brads@mainlining.org>
To: David Laight <david.laight.linux@gmail.com>
CC: Andrew Morton <akpm@linux-foundation.org>, Vineet Gupta <vgupta@kernel.org>,
 Guo Ren <guoren@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Rich Felker <dalias@libc.org>, Chris Zankel <chris@zankel.net>,
 Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 "Paul E . McKenney" <paulmck@kernel.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 linux-snps-arc@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] csky: Emulate two-byte cmpxchg
In-Reply-To: <20260917100435.664cf00d@pumpkin>
References: <20260916200215.21774-1-brads@mainlining.org> <20260916200215.21774-4-brads@mainlining.org> <20260917100435.664cf00d@pumpkin>
Message-ID: <F5B68A82-2A9B-43B6-B45C-205E81379163@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 17 September 2026 10:04:35 BST, David Laight
<david.laight.linux@gmail.com> wrote:
>On Wed, 16 Sep 2026 20:02:13 +0000
>Bradley Morgan <brads@mainlining.org> wrote:
>
>> CSKY has no two-byte atomic compare and swap, so the __cmpxchg()
>> switches in cmpxchg.h let case 2 fall through to the undefined
>> __cmpxchg_called_with_bad_pointer(), failing at link time. Route case
>> 2 through the new cmpxchg_emu_u16(), which now takes natural u16
>> arguments, so the (uintptr_t) casts on __old and __new become (u16)
>> casts in all three switch instances.
>> 
>> Signed-off-by: Bradley Morgan <brads@mainlining.org>
>> ---
>>  arch/csky/include/asm/cmpxchg.h | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>> 
>> diff --git a/arch/csky/include/asm/cmpxchg.h
>b/arch/csky/include/asm/cmpxchg.h
>> index db6dda47184e..e53628268e8c 100644
>> --- a/arch/csky/include/asm/cmpxchg.h
>> +++ b/arch/csky/include/asm/cmpxchg.h
>> @@ -65,6 +65,9 @@
>>  	case 1:							\
>>  		__ret = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)__ptr, (uintptr_t)__old, (uintptr_t)__new); \
>>  		break;						\
>> +	case 2:							\
>> +		__ret = (__typeof__(*(ptr)))cmpxchg_emu_u16((volatile u16 *)__ptr, (u16)__old, (u16)__new); \
>> +		break;						\
>
>Did you check that compiles?
>It needs to compile without a warning when exchanging a pointer type.
>I think it would be better to make both __old and __new 'unsigned long'
>adding a cast in the definition/assignment to convert pointers.
>aka:
>	unsigned long __old = (unsigned long)(old);
>
>(The cast on the call is separate from the type of the function
>parameters.)
>
>Not a new bug, but there also doesn't seem to be a pointer-integer type
>check here (there is probably one in another architecture).
>
>I think that means these compile:
>	int i;
>	int *p;
>	...
>	cmpxchg(&p, 4, 5);
>	cmpxchg(&i, p, 5);
>
>Simplest fix is probably:
>	unsigned long __old = (unsigned long)(0 ? *__ptr : (old));
>
>David
>

Makes sense. I'll just do a V3 adding tags and your fix, cause csky ? And
the main patch is the one having issues in sashiko.



>
>>  	case 4:							\
>>  		asm volatile (					\
>>  		"1:	ldex.w		%0, (%3) \n"		\
>> @@ -98,6 +101,9 @@
>>  	case 1:							\
>>  		__ret = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)__ptr, (uintptr_t)__old, (uintptr_t)__new); \
>>  		break;						\
>> +	case 2:							\
>> +		__ret = (__typeof__(*(ptr)))cmpxchg_emu_u16((volatile u16 *)__ptr, (u16)__old, (u16)__new); \
>> +		break;						\
>>  	case 4:							\
>>  		asm volatile (					\
>>  		"1:	ldex.w		%0, (%3) \n"		\
>> @@ -132,6 +138,9 @@
>>  	case 1:							\
>>  		__ret = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)__ptr, (uintptr_t)__old, (uintptr_t)__new); \
>>  		break;						\
>> +	case 2:							\
>> +		__ret = (__typeof__(*(ptr)))cmpxchg_emu_u16((volatile u16 *)__ptr, (u16)__old, (u16)__new); \
>> +		break;						\
>>  	case 4:							\
>>  		asm volatile (					\
>>  		RELEASE_FENCE					\
>
>

--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
