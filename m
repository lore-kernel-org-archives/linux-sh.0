Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792655883;
	b=WOmL7ps8daKX07BwYCCT5LFgAgwhR1/+HBWeEYWYD2oNl2qzBIPfZ+blQfHTQtBneA+y
	 raaS1xI2zrOziXOyPSUvBCoH/y8fPz26NAUWLsYxtf3WB9gF5Zg5DBC+8elVmqXun4o+5
	 Xr/8q+B9t3GEy9sncP65XaG4eusmIzHHS+5G5t49keqmc7Qc7DgWl2C+VKkyAoSfXRo6t
	 5uR99EF+1ABjXnltsUwGbVjnjyo1luEtRbv64zray9OwKiBZqS59O/YJ+RQlG6xuFd/Qd
	 SzXJzxEWO18GQx4/FbSZ9vGq1dT1jFhxRpS3n+2aDCsjiznUUoWk9zWtreJq2nPdwNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792655883;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=UbkcrVhug0AM31INW5/tZRh5XyQQUpxMrCXbZ/QJJr4=;
	b=w0lUKi80e9hOvJMfRBmuqnI9ZllSJo9J1TxdjwaqFKrwd7UbjydgANo2Q1WmREbl4mDp
	 fyUSwyMHrGnFc9AL0AABa0ThHGaVt9yOek13L/ROnYgSeKVfUEPgFfpMTpiRxSqevSLLR
	 jJRPBJIO9RLbWIFR11ZfmrcLuvWP+WcpQTagt5ZvXjkwm+QwTYYe4jSJnb8ZZBQcjLEWJ
	 EEKr5BrwaZ6Z2UD8T9Nfvw5fSdSYzuJ/7oLDzlKO4NLbxigKA6SOMtn0SNZ1yUFJ1rLEg
	 QRIL27i2S2oRLZDkgXt3SUx0REQsnK6fhwunJu7qj5nOZCPGTcxSGm9mkrDFE7JCiIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bzg1rekp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBDD606A326;
	Thu, 22 Oct 2026 07:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bzg1rekp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A841F000C2;
	Thu, 22 Oct 2026 07:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792655882;
	bh=UbkcrVhug0AM31INW5/tZRh5XyQQUpxMrCXbZ/QJJr4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Bzg1rekpbYxjZcy8zRMmHT02rqymR4bVC1BGHiMpMhtLztWvsOlH+oWYZhTE7+eOc
	 JJUKf6fk+Vhc6Ql8gfVjZ/KDTkSVIvkoCglSdfyKMkNmYHmBTyLpIMCJl5qh4DCiOD
	 IBJjSZaxS3ijXOFGu+QZyDY2gGvUFXDyXhTPL0SRb7BtD2T7lGjwJpOmDG2n7/teUu
	 7Hn3MKtT4apw8swOYVmmR9QXLgOVMTLnU0omWju2qVAk6M21Zk5vddJA2jZ4DSSDyc
	 +v8XK+y/URfv3kbADZudJtl0wUH5NQWXyuMUoVANeYsmiG8oZ7LlQH1o3sMa3DUYkG
	 l6wiehsaR4jyg==
Message-ID: <643ce64e-23d4-4de3-b7c8-8e1e9b268d03@kernel.org>
Date: Thu, 22 Oct 2026 09:57:58 +0200
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: soc: document Casio fx-9750GIII
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Artem Novak <artem122novak@gmail.com>, robh@kernel.org
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-sh@vger.kernel.org
References: <20261022063902.471383-1-artem122novak@gmail.com>
 <d6562416-05aa-452d-8fe5-a68cb8f50f01@kernel.org>
 <87fe0b0339e6f8763b9b385dbe8b8b5e587deebb.camel@physik.fu-berlin.de>
 <b8c7db3a-ad4d-4378-9e50-4c8591b93de8@kernel.org>
 <4f37ee0df5c5b0b29c69b3770c06a885f0562c74.camel@physik.fu-berlin.de>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <4f37ee0df5c5b0b29c69b3770c06a885f0562c74.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/10/2026 09:46, John Paul Adrian Glaubitz wrote:
> On Thu, 2026-10-22 at 09:33 +0200, Krzysztof Kozlowski wrote:
>>> There is a Casio calculator community out there that are users
>>> for this.
>>
>> Upstream user, so any known upstream open source project using Linux
>> kernel DT bindings. We do not need bindings for non-upstream users.
> 
> Yes, I realized that hadn't had any coffee yet and I misunderstood
> that comment.
> 
> I think that Artem is sending the users for these bindings in a different
> patch set. I have not been able to review the changes for arch/sh yet.

So this looks like binding for the board/soc, thus must be sent along
with the DTS patchset.

See:
https://lore.kernel.org/all/20231121-topic-sm8650-upstream-dt-v3-0-db9d0507ffd3@linaro.org/

https://lore.kernel.org/linux-samsung-soc/CADrjBPq_0nUYRABKpskRF_dhHu+4K=duPVZX==0pr+cjSL_caQ@mail.gmail.com/T/#m2d9130a1342ab201ab49670fa6c858ee3724c83c

Best regards,
Krzysztof
